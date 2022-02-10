Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2144B110B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbiBJO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:56:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiBJO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:56:22 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 06:56:23 PST
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F647C4C;
        Thu, 10 Feb 2022 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1644504983;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OIrI4v45rhf+U0BJx3jgsFmjum3Aw3c90TdrRj6IJow=;
  b=gkDEVh2f7/KAcQgPNIx+oVgwhtt2GOiNEnAngLbBBRpA94tNg1vEnnAN
   kMih3fxarUz9QoQGz1EXyrfPeCGyPtPpEq4f3pbLCDCcJhag4HkDMM+iB
   63A+grQvrui7pn6sj69USE7PY++PhsY1G1EwLS3X2BVL7b4bPKEC+A6Jv
   c=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: /advrcgPOSW1eDgZPudefTPu78u3s+9WmbaR8HtTaNoCRq/AYkvTUdqMyrlIyWXGljzmSs9gUD
 j/jvzAS5cfcygAIW2Yrx8Ss+0QCV+pjMJSw03VPw1Oan56GtANYgZ+HroYc0HisQcgq6Q2hQ+4
 j0eH6Xln55pQWFopf7pTJ+tnRxgIzGjUyVxacxYZAga1XAR3OWBJXmXI+yCJV5pt9cGGKHgP8b
 zZG7fs9eJf1B/HMZPAklh9btAN5+Ma2CnNWLhXEDRPFcEkdvT8aCPhHdMyRwJeFufvNTfegfw6
 FyZwIx44W8VLhMKiCTGi3yUc
X-SBRS: 5.1
X-MesageID: 63932629
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:iaHsDa75UX3Q1slixJoORAxRtI3AchMFZxGqfqrLsTDasY5as4F+v
 moaX2DSOayPazanft51aIuzpE0Bu8PUmNNjQQQ6qXhhHi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuV3zyIQUBUjclkfJKlYAL/En03FV8MpBsJ00o5wbZj29Yw27BVPivW0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pGTU2FFFPqQ5E8IwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Z1
 9pVrp2QTlkVP6zL3906VBVcGSFvFPgTkFPHCSDXXc27ykTHdz3nwul0DVFwNoodkgp1KTgQr
 7pCcmlLN03dwbLtqF64YrAEasALNs7kMZlZonh95TrYEewnUdbIRKCiCdpwgmxh3ZoQR6e2i
 8wxSScxdx7sSUBzK2g9IY0ThsKzu1/gSmgNwL6SjfVuuDWCpOBr65D9PdyQdtGUSMF9mkeDu
 nmA72n/GgsdNtGU1XyC6H3EruvOmz7rHYgWE7a73uBljUfVxWEJDhASE1yhrpGRjk+4RsIaK
 EEO/CcqhbY9+VbtTdTnWRC85nmesXY0RNNWHPQ77g6l1KvK5ECSAW1sZj1GbsYvuIkpRDgp/
 liTltjtCHpkt7j9YXuN/LCZhTC/Iy4YKSkOZkc5oRAtuoe55ttp11SWE4glQPXdYsDJ9S/Y3
 D+StykegOsvjM8MkJyc+lzDiTK9j82cJuIq3Tn/UmWg5wJ/QYeqYY209FTWhcp9wJalokqp5
 yZdxZXHhAwaJdTUzXHWHr1RdF28z6vdaFXhbUhT847NHthH01qqZshu7T53Py+F2e5UKGayM
 Cc/Ve68jaK/3UdGj4cqO+pd6OxwlMAM8OgJsNiPN7KihbArKme6ENlGPxL44owUuBFEfVsDE
 Zmaa92wKn0RFL5qyjG7L89Ej+N3mntknTuIFc+qp/hC7VZ4TCXMIVviGAHQBt3VEYve+FmFm
 zqhH5fiJ+pjvB3WPXCMrN97waEiJnknH5Hmw/G7hcbYSjeK7FoJUqeLqZt4ItQNt/0Myo/go
 yHsMmcFmQGXrSCWdm23hoVLNeqHsWBX9ilgY0TB/D+AhhAeXGpYxPlDKcVnJ+R7nAGhpNYtJ
 8Q4lwy7Kq0nYhzM+igHbIm7q4pndR+xghmJMTbjaz86F6OMjSSQp7cIpyPjq3sDCDSZr8w7r
 +Hy3w/XW8NbFQ9jENzXeLSkyFbo5SoRn+d7Xk3pJNhPeRqzrNg2enKp1vJncdsRLRjjxyeB0
 1rECxkvuuSQ8ZQ+98PEhP7Yot7xQfd+BEdTA0LS8a2yaXvB5mOmzIIZCLSIcDnRWXna4qKnY
 ekJnfjwPOdexARBspZmEqYtxqU7voO9q7hfxwViPXPKc1X0Ve8wfijYhZFC7/QfyKVYtA26X
 lO01uNbYbjZatn4FFMxJRY+arjR3/8jhTSPv+8+J1/35XEr8ePfA1lSJRSFlAdUMKBxbNE+2
 e4ktcMbt16/hx4tPorUhyxY7T3RfHkJUqFhvZAGGo77zAEszwgaM5DbDyb35rCJaslNbRZ2c
 mPF2vKaiuQO3FfGfloyCWPJjLhUipk5sRxXyEMPegaSkd3fi/5rhBBc/FzblOiOIsmrBw6rB
 lVWCg==
IronPort-HdrOrdr: A9a23:9sm/w6syedNuE6wE+h1VWyBK7skC7IMji2hC6mlwRA09TyXGra
 6TdaUguiMc1gx8ZJhBo7C90KnpewK7yXdQ2/htAV7EZnibhILIFvAZ0WKG+Vzd8kLFh4tgPM
 tbAsxD4ZjLfCdHZKXBkXmF+rQbsaG6GcmT7I+0pRodLnAJV0gj1XYDNu/yKDwGeOAsP+tBKH
 Pz3Lshm9L2Ek5nEPhTS0N1FdTrlpnurtbLcBQGDxko5E2nii6p0qfzF1y90g0FWz1C7L8++S
 yd+jaJqpmLgrWe8FvxxmXT55NZlJ/IzcZCPtWFjowwJi/3ggilSYx9U/mpvSwzosuo9FE2+e
 O87isIDoBW0Tf8b2u1qRzi103J1ysv0WbrzRuijX7qsaXCNXsHIvsEobgcXgrS6kImst05+r
 lMxXilu51eCg6FtDjh5vDTPisa13ackD4Hq6o+nnZfWYwRZPt6tooE5n5YF58GAWbT9J0nKu
 9zF8vRjcwmP29yV0qp/VWH/ebcHEjaRny9Mw0/U42uondrdUlCvgslLJd1pAZFyHo/I6M0kd
 gsfJ4Y042mdfVmH56VMt1xNvdfOla9Mi4kD1jiVGgPNJt3c04l+KSHq4nc2omRCeg1Jd0J6d
 L8bG8=
X-IronPort-AV: E=Sophos;i="5.88,359,1635220800"; 
   d="scan'208";a="63932629"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo/TcMP8AO0Op2oH8zIfCxcPCAdf/HKD6nGIohPxDdnxuNM7N6D+oOPwisa9+/EbfsCfRWyVHCZtTWkdcyWjfdMhEGS6wVLe2w2FCRKG+pQYD47vRy9Ozala1ubIF7iqyPemQod59kCbbHTBnmzYc448szAWjNY0mY/Gg6Zvg18C1A3RgPssMyq6OS8bA+iKYsXbBhwvBXwVSLI/4SHJ7T1mcGKvRAW9F92D4Sghbfnekt3h7AcA7IFqFoz5TfEKlBLdanppCDGiAsarS/xs4G065J+LuTFeAe0yBM4hEuTZc8i75Yt9QnWMbl2wcxyUraNPA3mYKutaXlIClZT+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqsJ0cvW4V2TbQ6w9+9ypQm/1w7jmuGw0wivrIQlrSE=;
 b=USsFlN56TTlP6U7Qg0F2tiSktvcFCNRA1QjBq0OLl0s6yCIoSkvXJNGD8VQoOoCTFktSW8ik5s5nDeO70n9OfvoNGARZnm2QwlLzVHCQIpIgEyOtRfjA8CCatW2Y/iZJEcS6cfGYli1sO3SgSXvJxbGXw0VvnXupB+1yHqzjni+Aa2EyU6ZwaMQ2nCRaMp/+7oErfXqQU0dVNblkQKRPEBuHTSXrf+GieB1cmUfe3R3tU6A5O4jwXvyhz5sAwnJjee3oEts+s9a9D2DAzDvpufOf4z2vhVeYKhie59bdcK+/rBPenuZAqCdSBY7mqTGp2QLPF73ZCwSl7NygROjDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqsJ0cvW4V2TbQ6w9+9ypQm/1w7jmuGw0wivrIQlrSE=;
 b=YEbzre9A77A21mzRk6qP7Rb0jND7pingxCztS/QpdV+20xmYJqTrlpDXDSuBrKaoQp1qzUfEsAgeD0Ww+lSkBna5UlU0VDDP3YZhv6RLOSDDjx4qjRDnnvt0W8QJa305jD4N2NlNWW5rz05ZnSzrhbwWAtz0ge75W3p/muvsPuA=
Date:   Thu, 10 Feb 2022 15:55:04 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Qing Wang <wangqing@vivo.com>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: xen: use time_after_eq() instead of jiffies
 judgment
Message-ID: <YgUnSKJD9vs3qrTC@Air-de-Roger>
References: <1644481765-14435-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1644481765-14435-1-git-send-email-wangqing@vivo.com>
X-ClientProxiedBy: LO4P123CA0174.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::17) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 539fb04f-738b-4ab0-b29e-08d9eca55543
X-MS-TrafficTypeDiagnostic: DM6PR03MB4779:EE_
X-Microsoft-Antispam-PRVS: <DM6PR03MB4779FEE68F99C9F817E595648F2F9@DM6PR03MB4779.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cuhtI+hoTNyNK9pNBlfEJBHVaH8DqCSpDl6awezMBj1tsawWAODyEoNksghIW8qLiUct5nZ/KA7O+CTabCMK1fTmU3HyVlhjKr9ac1R2dPt+n3F3+YrXUrV2rgCPMTm0nHRjguSbsaIjVkdm2xOgkkktdq9TAqScA/DGZsr9CNeO/JlN0UGeR8Zcpy3FkEoH866Tf7Z7fTDOYA3jwiyJtU1wklrEqqj9E58OjOY4Re0+iuPoIufu3tqHwmy5xJQWv1ziN6aLo/n7k4oZa86xbsl+vSH5tDjtlWlkj/zlQW87SbFKKW399N4zTGxNNuaOlscboEYX7s68LYN7N9gAkKP2fkVkLL+lmlAXOXGlZRDElzt8gsmXivUfWlb7uXUvN4Z4gg/tOE2IEzyNa2oByNc0lgCcQaacchXPPUXACkeKMhkCgEjiCOwOUvHJUCb0lbCQugP2rxTi7yhJVLJH3iKYKpIGDa1ejjALPUXAjFIP70MMmwALX+yzzzehLksEEUkeLW+0Hc7aUNa2Xt7ncsG3H2nJsMDZVJLkhvTzUsSEOXABy5CqDJQ4aYH06xuvcB7kscYciY7yP1IWG0dIqzij9zj2meo4Mu6dt6ABExNM76tkM2cQ7IOzVJ1K15qN2eTSTSdkk08MHMVSXMv0S0ka6ceVkcFswSih5LYiDhhDssQHJ6uOHVr/tkCXHCz9Pm6rvJTSi3cJbfX1wtytXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6666004)(54906003)(6512007)(5660300002)(9686003)(4744005)(6506007)(33716001)(6486002)(86362001)(85182001)(316002)(66946007)(6916009)(66556008)(82960400001)(38100700002)(4326008)(8676002)(508600001)(26005)(186003)(8936002)(2906002)(66476007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmRtR1Irb1cvYUlEaXJ3ZVVzcGJlZ0hWbmsxRGRDSHBnZEcyQVZnVlZJT29S?=
 =?utf-8?B?NjJLY2VmK0NncTdmb1hSSXJXQ2Z1VlhjN0NsQmhoWVVGTFd1VXpaa2VtL3Iy?=
 =?utf-8?B?VFhheGZIaHhxYzAyTVZ1c0U5N3Z2ZTBnc0l5bFlKUkxmRVo3TWRhU2xIbFBh?=
 =?utf-8?B?bDc2alkzNmN3SnU4L3B3QjQ4bkJZSVgwMTV1WUxKc1hEZVErT09NenVTZWdz?=
 =?utf-8?B?cXlmdTd2d1p1NXNGZmVVZzFRckZXd25oeUYvVyt0OEFFOVZTc0EzVm1OWGRt?=
 =?utf-8?B?TlpNcDV0S2YwcnFIWm1meGRuM0VlaTNuT0pDcXA5K2pKdEhmbEtRYXRZVGFX?=
 =?utf-8?B?NWw5dlhXUEFvRWRwRFZhcVdYZXFnSEZOb3paUUprVEhhMmV2MW9Bd0hJVnVS?=
 =?utf-8?B?bFhsODVNZ1ZON1A3K3FyUndyajlQcmdYcE5FTCtpbjZ1YUlLK0M0b3c0MndJ?=
 =?utf-8?B?L2d1Q0gySmNpZ2VhazdYT21zcW1sMkhKY0RrZGZEV3JYa1kzNThXRDNRQzZ5?=
 =?utf-8?B?V3d6UkhncDMyMzBJci8rSzgwR2hiVGNJM29UN0xKZ2Z5N3pGQWg1MVVZWGRU?=
 =?utf-8?B?aGtVUHJPOEp3VU9HWVBxY3gzQTFoRkZhaWdBS0RsNGVRV0YrRGxZcVd6a2dR?=
 =?utf-8?B?S1BNQndLNyswRnlmWWdzSXZZNHYwNk5DdDBJMnFNVy9LUW1sUmhiL0FZclpl?=
 =?utf-8?B?UU96N24vQXk2Nk5zdEhBMVFIVEo1clZaeVFZaE0vc0RGY0FGM3dIcWRoNi9D?=
 =?utf-8?B?bXc0bUJ5NVA1eUFVYnNuaTdoU0R5dnYweVdxWnE4dWVEeitJUEwrN1liZlFv?=
 =?utf-8?B?MW43Y0FlTDNRK1pYTkZDczdGbVh5WnBXZDA3dFlCRkVqZWV6dDBnZHVCZExF?=
 =?utf-8?B?R05rVDVkbGtWckpGZDNuTElxYWwrdGdFeHRGMlVQNHQ5SEQvK2lIM0F5YW9P?=
 =?utf-8?B?dUVmbDNiVTZFdkI5L2x3NEdDVlRQYnlDQmo1QVFUd3RMWEZIOVpsWHd0UDU5?=
 =?utf-8?B?WkVSSm91Yjg4Ui8zYURZdTFDeGpRUGhBR2wrMGU3ZWhnVm1MYjNpVFc0cEp5?=
 =?utf-8?B?Rm5yR1RLSHY2SDEzUUN3bi9yVk93SFNnSHpOc0dVOS8wR1dZTTcxTzE5Nytl?=
 =?utf-8?B?UENtZmIzT1J1OEcxUFR3djN6N0xMVUlwTnlQQnpEU2JEVzBpTjVrdDRpUmUr?=
 =?utf-8?B?MytYbFBzdHJKUHRqOGpFSjdTVDhvR0R1S0U2UE5hNWVuZzBiQzJFK3dEbHla?=
 =?utf-8?B?bGNEcjhHSlU1ZGxZc3d3SmQ2eHg4cCt5eGMyNTVaVG1TZWZXYWZiWXpGd1Zm?=
 =?utf-8?B?K2xpNzBpN1BHWFJwY2FWNitiNGlHVjFSWHhod1ZYTUVHT1o0MkRSS2sxc2tO?=
 =?utf-8?B?NlVQQjUzdVkvZk1WTndJbUFqbVNGdTZaakRKNTcxUDNlMXJTR29sUXgyUVVw?=
 =?utf-8?B?UHRUTFliTWxsVVBpVEMzeWtyN3IzMHlidjRNeS8vcnhuZDdXYXJYbnJQVGcv?=
 =?utf-8?B?NkdZdVRMdTloRUg0NVFOSWs1R1BkK3M2NTdyKzBuOGxuYm5nQlhsVFdZMmxa?=
 =?utf-8?B?aTJaYTBhOW9Da2lzTFFIYUw1MU0zckxtTitsRHdEYnAzNFZ0dDVhWlJPemo2?=
 =?utf-8?B?RkVxVHpoMzN4bCswdmt2UVI5OVh2bm9KbjVrTUh5bmtSSThYTGZHVTNOdjcv?=
 =?utf-8?B?UnlVRDV1ZzFIQ2tjREhQTlhrQzlaMTNWejZHai9ueEJYdHc3bm1lZ0RzcWZy?=
 =?utf-8?B?WlBPRHM0QjlmeTNUcWlXN2JqdjJlbmhSWUEycHVYUHdUWVFEQmVvMkkzKzZx?=
 =?utf-8?B?Q0wrUkNrN3JXTmhRaXlNMzFCZTlIazl1QVVuRDBUb3lsbk8rc1VobWVYd3pU?=
 =?utf-8?B?cjZybm15eXdad0FjU2VubTMzemlJdHJrRXBCNnNpc0FGSWdyZk5YR2pYano0?=
 =?utf-8?B?MVAwOEV1b3RxMHovWCt0Z0FLZmIyNHp3VlgyUUQ4ck9Hd1ZKZUpnMUthRkxv?=
 =?utf-8?B?TDBVcWtubDkvU05URy9JN2IzMWkxOFIvYTNuUHFxN3FJUEF6WmlCdzQ0V3Q4?=
 =?utf-8?B?TFdXbFBwK3plbUhGWDArSXlMN3NFemd0enROa1dnOHF6SlhwNTlQSFN6cjVo?=
 =?utf-8?B?TTd6K1VVanlYRXYxVmRUUHpoSkhxQXNnZjhYampaTHV0b3lRQzlKT0E0NWYy?=
 =?utf-8?Q?21ftG8iLhe/Bc0vJO20d1QQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 539fb04f-738b-4ab0-b29e-08d9eca55543
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 14:55:09.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7RR91h20gMn3I72PieFiHLExwxnIkHj+HKRbzA2xqtztUOf92uCDt4aVXtPLEqJBpL1rrhdUmaxjbYPHR9Cog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4779
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:29:23AM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> It is better to use time_xxx() directly instead of jiffies judgment
> for understanding.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Doesn't look that different to me TBH, but if people find it easier.

Thanks, Roger.
