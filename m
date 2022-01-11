Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6349548AC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiAKLSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:18:36 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:13148 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbiAKLSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:18:35 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jan 2022 06:18:35 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1641899915;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+FoSMuDBKeH6aEXUH+JLFA1KOxwJzJTpMqM/2dl5nIE=;
  b=dBWYRoX1nxvPUpI7e949THW0k4kuE0el6T6LEVYqc5ZFUkp6qG1XZvvU
   ntAwwiZPCvRf1pH8IXGQ6b7vYhO4n2x5TtcHqLgv9vclzzX4yOkw+dNcC
   4s7Sl2gQdThonbzY4Ph59Pr5+iOxMEgEzSPHmKW7iQ5smvSZLihyInVfz
   g=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: +LNhzxgyQIwGFZ5VV6qDOzBvNMLcq5gBJ6Qly+qzJynxF/aJZ8v2GSXyhhTU1Qe/XUzsCWs9ZG
 zndvA2sFmWxFp/cdUOnSlAFe8dTD/Mf3c0uz/HvLaImKGJhuSGarQm6IjfZcBJ+gmA3j2jcOzG
 b4t3pmzFrSBoNCZwA4RVbkukkIWutLJw+BoYXWH/QZr40gryeOjqieLlAuzPt8hJ83lIF7nNCY
 2FpP3TLXoE7KuPoI+dWwD3xmKs7PlgCOkJADSAkw17s7DrPgaM3dgpITfAoA/cijtipM9Lh/vJ
 MbcsE9njnUW6KClRkHINz1jF
X-SBRS: 5.2
X-MesageID: 61727851
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:zlVqz6p1B8lhTSNjk34AyjEBx0peBmJrYxIvgKrLsJaIsI4StFCzt
 garIBnQOvmJNGL3c90lPd7goBwDvpCHyNFjQQdo/iA9Hy0b9puZCYyVIHmrMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlZT4vE2xbuKU5NTsY0idfic5Dndx4f5fs7Rh2NQw2IHgW1rlV
 e7a+KUzBnf0g1aYDUpMg06zgEsHUCPa4W5wUvQWPJinjXeG/5UnJMt3yZKZdhMUdrJ8DO+iL
 9sv+Znilo/vE7XBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XnRfTAKtao2zhojx/9
 DlCnbHuViVuGYv2ouYyUCRJIxNDI6JsoZaSdBBTseTLp6HHW37lwvEoB0AqJ4wIvO1wBAmi9
 9RBdmpLNErawbvrnvTrEYGAhex6RCXvFJkYtXx6iynQEN4tQIzZQrWM7thdtNs1rp4XQqyBN
 5dAAdZpRFfdbzoSE1YqNL8Vob2q1l/CfSxW913A8MLb5ECMlVcsgdABKuH9atGMAMlYgEucj
 mbH5HjiRAEXMsSFzjiI+W7qgfXA9Qv5V5gVD6aQ7eNxjRuYwWl7IBkXU0ar5Pq0kEizX/pBJ
 EEOvCkjt64/8AqsVNaVdxm5pmOU+xQYXNFTO/M15RvLyafO5QudQG8eQVZpc94+vdU1bTUv3
 02OmZXlCFRHua2fTn+19bqOqz62fyQWRUcHZSIVSwYt6tzqsoY1yB7CJv5qFK+6k9rvGBn5x
 jmYqy54jLIW5eYB0L+65hbAmC62oYbSTR8d4R/eVWaoqAh+YeaYi5eAsAaBq6wadcDAEwfH7
 CNsd9WiAP4mIM+StmuqZt83Hp6q2ue1AgDCjnQ2Nsx0n9iywEKLcYdV6TB4AU5mNMcYZDPkC
 HPuVRNtCIx7ZyXzM/IuC26lI4FzlPW7S4y5PhzBRocWOvBMmBm7EDaCjKJ690TkiwASnK42I
 v93mu78XC9BWcyLINdbLtrxMIPHJAhjnQs/prihlnxLNIZyglbPEt/p13PUP4gEAFus+lm9z
 jqmH5LiJ+9jeOP/eDLL1oUYMEoHK3M2bbiv9ZAOJrLbe1s+Qzx5YxM0/V/HU9Y+90iyvr2Zl
 kxRp2cCkAav7ZE5AVjiho9fhEPHAs8k8CNT0d0ENle0wXkzCbtDH49EH6bbiYIPrbQ5pdYtF
 qFtU5zZXpxnF2qbkxxAM8iVhNEyJXyD2FPVVwL4MWdXQnKVb1GTkjMSVlGxpHBm4+venZZWn
 oBMISuAEMVTHFozXZ+GAB9tpnvo1UUgdCtJdxKgCvFYeVn28ZgsLCr0j/QtJNoLJwmFzTyfv
 zt6yz9BzQUUi4NqotTPm46eqIKlT7l3EkZARjGJ5reqLyjKuGGkxNYYAuqPeDncUkLy+bmjO
 roJn62tbqVfkQYYqZd4HpZq0bk6u4nlqYhFw1k2B37MdVmqVO9teyHUwclVu6RR7bZFog/qC
 FmX89xXNOzRasPoGVIcPiQ/aeGH2a1GkzXe961tck77+DV27PyMVkALZ0uAjylULb1UNoI5w
 Lh+5J5KulLn0hdza4SIlCFZ8WiIP0csaaR/u8FIGpLvhyoq1kpGPc7WBBjp7czdcN5LKEQrf
 GOZ3fKQm7RGy0PeWHMvDnyRj/FFjJEDtR0Wnl8PI1OFxojMivMthUAD9D02SkJezwld0vI1M
 W9ubhUnKaKL9jZupc5CQ2HzRF0RWEzHohT8mwkTiWnUb0i0TWicfmQyNNGE8F0d728BLCNQ+
 6uVyTq9XDvnFC0rMvDehaKxRyTfcOFM
IronPort-HdrOrdr: A9a23:ankYLaziIgMQgF2FMda3KrPwIr1zdoMgy1knxilNoH1uHvBw8v
 rEoB1173DJYVoqNk3I++rhBEDwexLhHPdOiOF6UItKNzOW21dAQrsSiLfK8nnNHDD/6/4Y9Y
 oISdkbNDQoNykZsfrH
X-IronPort-AV: E=Sophos;i="5.88,279,1635220800"; 
   d="scan'208";a="61727851"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtZlmloa5NjDpfBJQTxhye7c7JuLPtDAkvx1Q6hQ7VOdvm+PpSU2xvfbuYYAZIdIyo+hb+zndZOd/iMLaNHHdwBj09WhOIYQrsYXWux/d+n7E/sNhrKn1M8Rg3hfLOrGrDc4NrYfuNP0yHJFrJ/ctJNXgg9L/fPyasCT+1PYDfkaV28QVRzNlWMnWHdqljyeeB+8oxtkklauJT4ygpxvFOb13mXCAcoap/mEeLn5oUrxXsqynyj80tdYZ7dTt3MdfqVDT1OtFQua9cIt0EulN9rJj5CSeAO2WLRt6lGf9jIUp2DtgsPvqkrLwzd/VnPwr+XoSXIrv4rheQtf/DdAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vbVjBIbKzztlAe9vCcCRtVaFrKaWxxjBst7/u1OVq4=;
 b=FijY9vWbTiWmmKqfl5e/6IYr+Hl5trJs/tCkF7he/+aqmDTJSD68SwBxUEarjmgZRSVSw2R6k4YXAgugCDF9Yp/+JGqF46M8wzTET9u8VIyl8HKI6oky2jrsyUV/cPLe1dIV/Mbx6qqWXGxCmOzQUYvg72I6Y9R4icjzbuwdFzGwkbeOYYEY32toPRLAkuSIzyirEklzM7nrkRyj/e9tQvUc36l3/kHaVad3a/HBGbiftinbhDbOufIx3HJHC1S8fH6rxgA7e+5Nxh8kh7/cEBw2jRrRUlX+2unVUlFymuL+MVcRIwx+o1stdH5BuNuu4pvbw6BMtYDoenCOXwlgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vbVjBIbKzztlAe9vCcCRtVaFrKaWxxjBst7/u1OVq4=;
 b=V2h5QEMyn+h1fHP6YxkjXyUF1ZToXayYCZ98Dv0F9OshjQb48GHzr8OH7rUFU5AOi+jh6MpxDp9VXK+g6qicChyA21YpW//UoxWAlAXlc1BEOOYHydiYigIPGVz1v1OUb0RPp2vpxfOScC2TVx/xWHcRpCHMhMy2Pn9AKnMhrs8=
Date:   Tue, 11 Jan 2022 12:11:15 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Maximilian Heyne <mheyne@amazon.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Anthony Liguori <aliguori@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen, blkback: fix persistent grants negotiation
Message-ID: <Yd1l01jTPwx5oBuo@Air-de-Roger>
References: <20220106091013.126076-1-mheyne@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220106091013.126076-1-mheyne@amazon.de>
X-ClientProxiedBy: MRXP264CA0014.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::26) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc51d806-8853-454a-0c36-08d9d4f3182d
X-MS-TrafficTypeDiagnostic: DM6PR03MB3579:EE_
X-Microsoft-Antispam-PRVS: <DM6PR03MB3579241225EF1DF9195BDD188F519@DM6PR03MB3579.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bG9W7xQbLt+Fz/Bw5ozsPnIiTsbvl1uiENCeEeeyeXzjsNnypH5eSBvhnN8XwnJ6T0U7kHsT56bxhuBUy+0/0OcYIvUxIjH+SX8k4DqpkW5fKO+ceLMQm9FlxOI3oWBJK3tou+J/dgEIJzF+43g9r13idBA8gCqmZt58rjtqfw8iO26p6IHjneKk1VSKnYA4JMNPNwRLn6Atmlv/dJHb3xnUnFLPWGOSIIuxsALnoZS8BTH910UtgpR0+xQnAzEdGNd3JTba6SBYseEBAsegJDarpOmGv99eQAR6d8qAVoC3EC29QecUaxdXRbGDGI6Mi7+0csh3hi6P60r6hu4leKYFo6Sl7rRvDOwk69dtHywofaXRVUimzzGjLWka/FWM3UivEAVuP/7VRneH7MFv/Wjei/WVhv7M6d2hhy/ZHLdIQ4PLTxUSlL98bYqxqXp1nrqxLTtqlyjDY/uVfsa871dYP1g6jCr5m6C7hYR6NGA6FuPnu/Kr60yCzRLv0Nfh/lzXgsB1Y+UvnidQOJwBUetXC39XUNYQ9Ju7TIgztx57WN3PN7jyOjxcJnWC1OJBhBu/aP+zekaIBvtQtTu7KpiGJEcz6nBaj/26Vj1Xp/ZH3/VAHxVuM2x8IYt1AiNVtPkbZzdmwTJFNE34ha22+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(82960400001)(4326008)(9686003)(38100700002)(83380400001)(6486002)(6512007)(5660300002)(6916009)(66946007)(54906003)(66476007)(66556008)(508600001)(85182001)(8676002)(2906002)(186003)(316002)(26005)(6506007)(6666004)(8936002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjRBUVYzcmVyWnZtYUlkZS83ckQ0T2hvemxFUXNvQSsrRVY1aGdPM1NsWklY?=
 =?utf-8?B?U1BrQUk5bXArbElrc3g0c294SEJ6OEZtRnhQdjVxU3Uva0N6OWs4d05NZ2VT?=
 =?utf-8?B?RVZFSjQvZVhTZmJOdWttdXpzT1ZkdVR6ZWRaZjNMTmRNb2NuaXR2cUlOVFBo?=
 =?utf-8?B?U3ZydWZPMjQyeU5PWG1hMXAwOUJUeEZPdjVCOGpDNjFxQnYxQ3RacTNTNS9n?=
 =?utf-8?B?bFpQdmJQbVhzeS9ZTW8wVUpza2VIYVNRZGxBZThiVFNjSnU2VHVjNUhJMkpR?=
 =?utf-8?B?V2R6TXVmVThiWUl1WGJ3Z1dnNlozT2pqWDFsNmJSVFhQVkMrL2ZRY0JLUVdB?=
 =?utf-8?B?NmxHVjQrRUpGbVVqOE5vVXdqTlZFZGllaDJBN1dHUEVYUEtBMU5zL0U2NXRT?=
 =?utf-8?B?YUdjdnNhN0k5RTg0SGtobFNXelN0aUJtQkNUeGpWTGdiYkFwSTNSYkVTN2NX?=
 =?utf-8?B?OGJ0aU1wUUNPUmpqOEw2dWxuWTFzZDFScWdwZUVGdG43L3JkWDVVYmp5d0JS?=
 =?utf-8?B?bGl6Z0JiM2xtQUs2dGtMZnFGREZWZzZzd1NRVVpkbFdDd0hkOGE4R0xQbmFo?=
 =?utf-8?B?U04xZWlPQjdCRmsvVXhKWGhSZ3hQVmpXak9XNHdGaGpTRUQzV2J3eUNMM3dQ?=
 =?utf-8?B?ZThQd3paa3BVNE4wMzRkUE5OS1A3Z2JlbU1LcXZzS1haZEFtZ29nb0xpRWhi?=
 =?utf-8?B?OFNYV0ZmdStTdUx4QVo1azVXNFFXOGk1ZjdtZnFIOVNsN1VlSFBaS2R6TnEz?=
 =?utf-8?B?WFZzZngvYkRLRVo1YURqcjJ1b0JOVUJ4czBrVGVQYXd1TnlNekdCSDk4cmU2?=
 =?utf-8?B?NndmRElkay9JSWJMRWZRUlFmVy9uZllnbllRTG9nalpidnNsYWJxTnRxY2pO?=
 =?utf-8?B?YTdsaExITXZnZmZOVmNjN0tsd0N0b2lFZzhWWmNmanZIdCt5WUFqcmVUWDQx?=
 =?utf-8?B?KzIvTVdmb2VhZ01VRFo3R3RtdGE1YzA1MUhHYXJvUUFPMk9VenFPdFJkbXJy?=
 =?utf-8?B?S1paSVRzQWpaMytnc1R4VHM2eXQxcEZZbncyREhJYjNUUVdsVTk2QzF2OFJL?=
 =?utf-8?B?UFpTLytxenJsVHk3alo2cHVKRXlUZkh0T09JQlgrRGZXZ2Q3VjVkL1k0WlpU?=
 =?utf-8?B?N3dWU2NXY2pZSitvMkpoaUhvZ0lzNDBUQTdLU0VsTnpkdC95MHp1K3UzS0Vt?=
 =?utf-8?B?TWIreXFnajVwdjJvNDFES2hhQnVpRDl4L1lRVTlaQUpscnJydHpINUVubGVw?=
 =?utf-8?B?ZDlXeUhJM01ZNVdOMEFMN0crVWZvQ3UzUSt5Nnk3VEcxRGVEVEcvZXVweFNN?=
 =?utf-8?B?VXU3Uy9RRG9ZVlhHcXN4M25sZFc0dkVpczlrR0pjdU1uWEcrRHFsdGlWcUVS?=
 =?utf-8?B?QnVETENrUytsNmJSbHRydHVVS1BkTTdhTEo5dHllVWttZFJKS0FsZ0Y5TTho?=
 =?utf-8?B?ZVY3bThDZ1hwNC96NUJlSjdSRnhjdXZzR1ZpL2RudnIyVXBCbUVkNXBQTmhZ?=
 =?utf-8?B?RjJDeVVTdnpUM0p0Zy9YNWRyZHdjWTQyMjFYdUp0dHV2TmJPMExOanEzektx?=
 =?utf-8?B?elRkUjIzOHQrYmk5eFpyMDAycTV2eUl6cU51WTRpM1M5Z3lKdTgyUEkxL0lF?=
 =?utf-8?B?TkxMRnltcjhMT1l0NzZZd0hRK2pDc3Q0YUQyRDA2SWhsOFJrN1JrT3NWSHox?=
 =?utf-8?B?N1l5TEpwRlR2T0pjMkdZeVpSbG5GU2J5KzJpa3ZyMXltUXVlN2xiM1FCRmpQ?=
 =?utf-8?B?VDlJbmF4RlVldmpTeWxQaUkvUkw2VDlHeHFHb3JtRWRZdnROQTg1cld5QlZ6?=
 =?utf-8?B?aHcwSyszTVBYL2hYYTRPNWo2QzYrcVhLUndkOHhFZWo1UmRKcUsrTmc3VUhZ?=
 =?utf-8?B?dWhHWlhuVmlBaGVpQ3ZIWXduUHQwSHFjZG1SaEkzbkx4TzZrU29kLzhXN1c4?=
 =?utf-8?B?QXlpUmcxcUw5S3Y2U0RXam55VllLK3VYU1JhdmdGYkg2ekxUMThzd1NhUWZZ?=
 =?utf-8?B?UTVwUTZXNS9pYXRud3phZTZvVll5SXN5cE90Sk9HY3pyLzhkbC9NbzdWeHdu?=
 =?utf-8?B?WklEL1o5bFZWY1JWMThEN2hIek5rNDFZc1VBVE55WlhjWXpaREFMU2l4ZkVH?=
 =?utf-8?B?VmZydUFMd2pqVXpUbTk0bDc3QklQY0FOUkdqZWJwUVYyRHliVkFZd1lHb0sx?=
 =?utf-8?Q?n+PpDa+MF45QWgnnhYfCo2k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc51d806-8853-454a-0c36-08d9d4f3182d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 11:11:19.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIumD4dZ8uZG4TnqleOgL4NRm58z8s/Ng23DGrTQdpgU8RWIXqlO+dsEp589sTzYXNFRX/Xr6QcsIXGtBxH5YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3579
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 09:10:13AM +0000, Maximilian Heyne wrote:
> Given dom0 supports persistent grants but the guest does not.
> Then, when attaching a block device during runtime of the guest, dom0
> will enable persistent grants for this newly attached block device:
> 
>   $ xenstore-ls -f | grep 20674 | grep persistent
>   /local/domain/0/backend/vbd/20674/768/feature-persistent = "0"
>   /local/domain/0/backend/vbd/20674/51792/feature-persistent = "1"

The mechanism that we use to advertise persistent grants support is
wrong. 'feature-persistent' should always be set if the backend
supports persistent grant (like it's done for other features in
xen_blkbk_probe). The usage of the feature depends on whether both
parties support persistent grants, and the xenstore entry printed by
blkback shouldn't reflect whether persistent grants are in use, but
rather whether blkback supports the feature.

> 
> Here disk 768 was attached during guest creation while 51792 was
> attached at runtime. If the guest would have advertised the persistent
> grant feature, there would be a xenstore entry like:
> 
>   /local/domain/20674/device/vbd/51792/feature-persistent = "1"
> 
> Persistent grants are also used when the guest tries to access the disk
> which can be seen when enabling log stats:
> 
>   $ echo 1 > /sys/module/xen_blkback/parameters/log_stats
>   $ dmesg
>   xen-blkback: (20674.xvdf-0): oo   0  |  rd    0  |  wr    0  |  f    0 |  ds    0 | pg:    1/1056
> 
> The "pg: 1/1056" shows that one persistent grant is used.
> 
> Before commit aac8a70db24b ("xen-blkback: add a parameter for disabling
> of persistent grants") vbd->feature_gnt_persistent was set in
> connect_ring. After the commit it was intended to be initialized in
> xen_vbd_create and then set according to the guest feature availability
> in connect_ring. However, with a running guest, connect_ring might be
> called before xen_vbd_create and vbd->feature_gnt_persistent will be
> incorrectly initialized. xen_vbd_create will overwrite it with the value
> of feature_persistent regardless whether the guest actually supports
> persistent grants.
> 
> With this commit, vbd->feature_gnt_persistent is set only in
> connect_ring and this is the only use of the module parameter
> feature_persistent. This avoids races when the module parameter changes
> during the block attachment process.
> 
> Note that vbd->feature_gnt_persistent doesn't need to be initialized in
> xen_vbd_create. It's next use is in connect which can only be called
> once connect_ring has initialized the rings. xen_update_blkif_status is
> checking for this.
> 
> Fixes: aac8a70db24b ("xen-blkback: add a parameter for disabling of persistent grants")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
>  drivers/block/xen-blkback/xenbus.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index 914587aabca0c..51b6ec0380ca4 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -522,8 +522,6 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
>  	if (q && blk_queue_secure_erase(q))
>  		vbd->discard_secure = true;
>  
> -	vbd->feature_gnt_persistent = feature_persistent;
> -
>  	pr_debug("Successful creation of handle=%04x (dom=%u)\n",
>  		handle, blkif->domid);
>  	return 0;
> @@ -1090,10 +1088,9 @@ static int connect_ring(struct backend_info *be)
>  		xenbus_dev_fatal(dev, err, "unknown fe protocol %s", protocol);
>  		return -ENOSYS;
>  	}
> -	if (blkif->vbd.feature_gnt_persistent)
> -		blkif->vbd.feature_gnt_persistent =
> -			xenbus_read_unsigned(dev->otherend,
> -					"feature-persistent", 0);
> +
> +	blkif->vbd.feature_gnt_persistent = feature_persistent &&
> +		xenbus_read_unsigned(dev->otherend, "feature-persistent", 0);

I'm not sure it's correct to potentially read feature_persistent
multiple times like it's done here.

A device can be disconnected and re-attached multiple times, and that
implies multiple calls to connect_ring which could make the state of
feature_gnt_persistent change across reconnections if the value of
feature_persistent is changed. I think that would be unexpected.

There are also similar issues with
xenblk_max_queues/xen_blkif_max_ring_order changing after
xen_blkbk_probe has been executed. We likely need to stash all those
parameters so what's on xenbus is consistent with the limits enforced
in blkback.

Thanks, Roger.
