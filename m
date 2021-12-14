Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67711474118
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhLNLGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:06:54 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:35831 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLNLGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:06:53 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 06:06:53 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1639480013;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OVIZOU/9NYSkNJbhKWqn/Qu9V/D7lRQN9h9G11OCn5Y=;
  b=diZpADF35JTdodJaIcSWE1YhubemUv9CoF2LotwmEA1NVTnrM7RZTeJl
   XKX+pBoG/xJCGLuQXEiB4gfvq1pMamhNK+sTZk/rvjQlm/KRtN9lCaMCc
   2JE3MqDB53ZZE8k+yQdYH4zm7ZApbPJJdElOHgBOzeAXVKU0zEEGedUf+
   8=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: J9rjl4mlP2VTxMoriNqN7P24mIzooBvI97LifaJAtoVpQHNZErkhS8CTkcdefS4brf7fCowUGh
 xIIgbRgJCMTHjss+oIlhTeHhrfzzI3xT62ZE5Zi3u4s20AU7+RaMQOfnZgn1BPP6pAcYo/C3iJ
 iXp1+aC5IDFepM7EympRPMQW2SRuZbo6A+2crItYu+Su0QnsqIAff9z3XlTqaru2LIhBp/LLOo
 QE3ihjIJO8JHrkeS7ONCcOPr6ta0MjPwrRfNclUgkWI+kTnIAM78BuhMUmBWULLzOfaRHd+u3F
 myGssBIckR5FCb2zBEamJ2RB
X-SBRS: 5.1
X-MesageID: 59914560
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:LKVXva5sGc+PicWeZo+d1gxRtDHBchMFZxGqfqrLsTDasY5as4F+v
 jBKW2+DPK3YZTbzfIhya9yy9ElQ6p7Xy9RhSgE/pCgxHi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuV3zyIQUBUjclkfJKlYAL/En03FV8MpBsJ00o5wrdj29Iw27BVPivW0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pGTU2FFFPqQ5E8IwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Z2
 M1slrfvRyESDrz1g74lYUV6IzwvIvgTkFPHCSDXXc27ykTHdz3nwul0DVFwNoodkgp1KTgQr
 7pCcmlLN03dwbLtqF64YrAEasALNs7kMZlZonh95TrYEewnUdbIRKCiCdpwgWZh35wTQ662i
 8wxUBg+czTJfEd1JnA9BbYOldqYnHXibGgNwL6SjfVuuDWCpOBr65DpMdzIapmAQcJenW6Gq
 W/cuWf0GBcXMJqY0zXt2mKhgKrDkD32XKoWFaak7bh6jVuL3GsRBRYKE1yhrpGRiUOkXd9bb
 k4d/CsyqrIp3FKkQ8O7XBCipnOA+BkGVLJ4F+w89RHIyafO5QudLnYLQyQHa9E8ssIyAzsw2
 TehlsPjAjFHs7CPT3+ZsLuXxRu4PjIUNikFfjMeShUe4MjLp5s6hRbCCN1kFcadhd3vGCrsx
 CiKoW48jrQXicMX/7qy+1nLhDXqqIKhZhUu+gzdU2ah7wV4TI2ofYql7R7c9/koBISWVF6ap
 1AfhtOTqusJCPmweDelGbtXWuvzvrDcbWOa0QUH84QdGyqF62aCXqsP7hdFFFZQKZw8S2PLU
 FKCplYEjHNMB0eCYahyaoO3Ls0ly6n8CNjoPszpgspyjotZL1Heonw3DaKE9yW0yRV3z/ljU
 XuOWZ/0VS5yNEhx8Nahqw7xO5cPzzt2+27cTIuTI/+PgevHPy79pVvo3TKzggEFAEGs/FW9H
 zV3bZLiJ/BjvAvWOHa/HWk7dw9iEJTDLcqqw/G7j8baSuacJEkvCuXK3ZQqcJF/kqJem4/gp
 y/mCxMCkQKi2yKWeW1mj0yPjpu1Av6TSlphYkQR0auAgSB/Me5DEo9BH3fIQVXX3LM6lqMlJ
 xX0U86BHu5OWlz6F8c1NvHAQHhZXE3z32qmZnP9CBBmJsIIb1GYorfMI1q0nAFTX3XfiCfLi
 +D5vu8tacFYHFoK4Qe/QK/H8m5dSlBBwr8vBBWRfYEIEKgumaAzQxHMYjYMC5hkAT3IxyeA1
 hbQBhEdpOLXpJQy/sWPjqeBx7pF2cMndqaDN2WEv7uwKwfA+W+vnd1JXOqSJGiPX2Lo4qSyI
 +5SyqikYvEAmV9Ltat6Eqpqkv1it4e++ecCw1Q2BmjPYnSqFqhkfiuM0/5Qu/Af3bReowa3B
 B6Co4EIJbWTNcr5O1cNPw55PP+b3PQZl2CKv/Q4KUn3/gFt+7+DXRkANhWAknUFfrB0LJkk0
 aEqv8tPs16zjR8jM9CniCFI9jvTcixcAvt/7pxDWd3lkAsmzF1GcKfwMC6u7cHdcchIP2krP
 iSQ2PjIiYNDyxeQaHE0D3XMg7ZQ3MxcpBBQwVYeDF2Vgd6Z1OQv1Rhc/DlrHARYyhJLj7B6N
 mRxbhAnIKyP+3FjhdRZXnDqEAZEXUXL9kv0wloPtWvYU0j3CTCdcDxjYb6ArBID7mZRXjlH5
 7XJmm/qXAHjcNz1wiZvC1VurObuTIAp+wDP8Cx98x9pw3XujeLZv5KT
IronPort-HdrOrdr: A9a23:T6VqpKi1Xp772WXbdTWMRGF78HBQX0J13DAbv31ZSRFFG/FwyP
 rAoB1L73PJYWgqNU3I+ergBEGBKUmskqKdxbNhR4tKOzOWxVdATbsSlrcKpgePJ8SQzJ8+6U
 4NSdkaNDS0NykHsS+Y2njILz9D+qj/zEnAv463pB0MPGJXguNbnn9E426gYzNLrWJ9dPwE/f
 Snl656T23KQwVpUi33PAhPY8Hz4/nw0L72ax8PABAqrCGIkDOT8bb/VzyVxA0XXT9jyaortT
 GtqX212oyT99WAjjPM3W7a6Jpb3PPn19t4HcSJzuwYMC/lhAqEbJloH5eCoDc2iuey70tCqq
 iHnz4Qe+BIr1/BdGC8phXgnyHmzTYV8nfnjWSVhHPyyPaJMg4SOo5kv8Z0YxHZ400vsJVXy6
 RQxV+UsJJREFfpgDn9z8KgbWAlqmOE5V4Z1cIDhX1WVoUTLJVLq5YEwU9TGJAcWArn9YEcFv
 V0Bs203ocYTbqjVQGYgoBT+q3uYpxqdS32AHTq+/blnwS+pUoJjnfxn6ck7zI9HJFUcegy2w
 2LCNUtqFh0dL5kUUtKPpZ0fSKGMB28ffvyChPhHb3GLtBPB5ufke++3F0KjNvaDaDgiqFC36
 j8bA==
X-IronPort-AV: E=Sophos;i="5.88,205,1635220800"; 
   d="scan'208";a="59914560"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJb9j3xzd4rFoznGnG7FCP278fOHYL7hDaXmUmbTPa728FVQzi1bgHOF6F/BBF+Kw6UgHXEdVFjuaSXflJfxgaQzjdSo02bqvHvBo5FYtJK/YGd2+5J8Qxe9Qn7c43v7qcw3OvnxqqeZMYiycpGHhFKVY0uxmYS5gnf6431lFxWDoka+k38MFsHJu5ZBfOCC9U1u4yXbgUkPiUN8pwLyH7O+Uv6SekCZBZFxGItGL3yDCYRyEwCNoeX7CPjuJpWdVR5Sx9LK3wSXXUDtektiPoExzR/pBCPXlGqAtWN/xB2mEG/cC5mJyRFh3FAMS/wJZZ4iV0fQD+rwmkmzbrmVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kkztyy0W5pmcTI4txdMVindIopx+IzDgPSYR4q6jFf0=;
 b=Y81F3u/rOvT1UABPRS7+Fu7njubeaBw3GEwVKHTkoRItV4TcJUB2DT0nxsKl8Zf09W/dIXfdAyYn/Oa5Ar62ibxhWk9SWNrN7fhUgoGdp2TUBR3qtoEPYv6NAxJosuhrWoPkZ/humC4z/m88zozbzkWiHDrV6iQ5pMtg9awIYmzM3p+JRQ7bayktXwO+VDXXFvmmtg/t5rNROB2x0y05M/1rPIZ7uStV4RJFbl5osfoRaqXyreGnIpWrIlTlO4BJdvFP4h9tFX3vZwQ1d3kO/xXVD9DDZ+bLvYGCbPVPaRK8fc3TA9erASOKG+8TN1JrKYhh9pK0PdVFcORco1IGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kkztyy0W5pmcTI4txdMVindIopx+IzDgPSYR4q6jFf0=;
 b=qr+dQo7OGzrQrlvp/Bz4SCCvGyPh+nZjYsWYs8fPNDC0fTigzFi3j5QoU/JczKNPFWij47eqL3IcJDREqmFFBfvrCDdPQVlN1jc+8plaW1KvNZWNHxWaTXwaAyKtIgDzmrpD6ezLiAE26ociNh7bNaUpfMoFUMer0DRPePSyoiM=
Date:   Tue, 14 Dec 2021 11:59:39 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>, <axboe@kernel.dk>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] xen-blkfront: Use the bitmap API when applicable
Message-ID: <Ybh5G2ziyRXkz3WF@Air-de-Roger>
References: <d6f31db1d2542e1b4ba66d4cea80d3891678aa5a.1638476031.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6f31db1d2542e1b4ba66d4cea80d3891678aa5a.1638476031.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99afef81-656e-4b52-b7ae-08d9bef0d59c
X-MS-TrafficTypeDiagnostic: DM6PR03MB4603:EE_
X-Microsoft-Antispam-PRVS: <DM6PR03MB46032A8C372668D1D54BEA248F759@DM6PR03MB4603.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjDf5Wdg2n8t+hzFbXz3OjO4x+2JkPIzVcYfnUUjsynwpOae8IJfV5ltUP+6qbM1w/Az2x5oL7Pkk9iT5k1Sj7yFWI/wiGWwYZVr/21LSEcxpzayjAV9iZhbTRWWp04HslGCza7lqF3CnMq/wYTCdI4OOCToaaM3FZUAwH9JVeu3g8hTyt6mOpxuNMTh6/1LdryfpxzFSH67sDDc8R/8bPo9ZWMLabTqeTMGiVVADRpH9hCg79MCE1uq6DvVF4Ql+rcm7i+88HUwziOWWev3ClRXJrn2koPs59Zbn/2JzrcdGyaFMBDhtLJPGxowHbXT89mhzh7M+Ox4xHF6kYGrfNS1XEihVUfwIquKz2bt/XJ/yVSNmgpDnKPTkyXPTN9VpUoqxmk6CtthcrVmmZkIzQW/Fkdlva4QyyqDI4aVrDEyLNzT1djXE30VO1MWmGRABA7lAg8fnBy7NEP2h4gDpow4slhYIldTf1EXDZ3T0+dw6o8fjsCR/tygsy0ITdNLvdnAjnXPriI6gKWwsyWK7tF1wG+nDVCRaoKyRC8Y6FupJRCF0IyDZDWmpZL7nYGSizOPyQywnwk90Evt0/I4avPivGTU8v6uLUnn+v5mD/RDd5blEphak60kbJBa2EVzEjjtldXcob9HfQgj2O+21A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(316002)(8936002)(508600001)(38100700002)(33716001)(6916009)(6666004)(82960400001)(4326008)(8676002)(26005)(5660300002)(85182001)(66946007)(6512007)(6506007)(9686003)(6486002)(66556008)(66476007)(2906002)(86362001)(186003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRSNmpQdi9aMEIvVUsvU3NaR1NaOCtRRFN1Y3UwRmQxWmhQTWZyc3JVUWFJ?=
 =?utf-8?B?MndJYzhxYUFwTlVmUmp6M2tENDlFWm1CaE94VG9SZzlCZys2dzkwc28zWHBP?=
 =?utf-8?B?cy9UZHFlc25WemFlK002cWlmbkxKQ1hqd05pM0NVVDAyS2dSVWM4TEYya2JL?=
 =?utf-8?B?a2NMR0dNU2lYby9aQWxDKzVDMVpsWEkwMkNmRER6eDE1d291VXA4U0d2T3NY?=
 =?utf-8?B?aDJZOER6RmlMY0d5eVpDTVh6dk5RV1FEOUNDWEpLL1VmN0gyK083NC8rTTNU?=
 =?utf-8?B?UE9YSi95elh0WlJIREcwa09wVTVFaktVUkhpUzBMYmp1ZTN1Y0NtZUdiY1d3?=
 =?utf-8?B?VnpUclNocmpSVDRXSWFvTXdwMG1KeEZ6UlhpQXFGKzFtaDN6eTBWWm83MTZ3?=
 =?utf-8?B?V285MVZlWkVuS2ZKRWZFT0pyN0dwVEFxTUVxZlhRVFUyQURYRENQZUNnTmxY?=
 =?utf-8?B?cVFnNitkbmttZVo5SXdLNWN0VTFXUkZHVCtFOTg2ZzUvclhPTHJrQ1g0amxI?=
 =?utf-8?B?cVJocnJXSjVQN0dFMW5LOUVqb3F3c1ViNnFnbDV6YmJiYm1NRDhVOENXeEZo?=
 =?utf-8?B?Y0dPQUlESWpFSk9VQUFJSVBqZityL3BKTGVKeUZPcy95OG5OUDRUN2ppSTdn?=
 =?utf-8?B?M1ZPZFVhMUw3ZTBCRFVrTFYrZCtwZGtYWGJlZVZFbHhoVmZyM0VLVVJnUG84?=
 =?utf-8?B?UEZrYWM1aFRYYktZdytjdmtmV0dTYzg1bUlVejZsK0xiRXFKOXE0bTVrb1Yr?=
 =?utf-8?B?K0VIS0o0TkpJeFUvMThZNDEwOUpVWm02M2xWMmFuUjlwdmJkbE5EMW15eFBn?=
 =?utf-8?B?RkZ0MHBlVWlwYUFkbUU1Ykt0V09KTzhpTXluL2JvTTZKdW5YTXFzc0tMclhJ?=
 =?utf-8?B?RkxjbVFhVEtiTjYyNGZMUXQvUEMrUi82MGkwZVpOLzBmWG55aUFaTVVXZEp5?=
 =?utf-8?B?aldNVHVydkdFSUdobXVldTFremhqNUpsR0NmQ01ZbGJEU3YwUXZiZGtDSmM2?=
 =?utf-8?B?MzVETHBkMzZKQm1POTc5L1hhQjBOU0hlWkJuNHJVNFZLeEFJSitQdDJGZ0Yr?=
 =?utf-8?B?bjltVUFBaFdZbmZiek9XTnh4Z3IvOC9HTENCKzQ0ODhySnhidG9aQ3RJMVU4?=
 =?utf-8?B?bTloQStUTTNhanZjblptKy9ZdGw5SDFPTHNSckpIcXZray8rSXA1b1B4VDF4?=
 =?utf-8?B?ekRTSCs4QXJHSUpwd1lyRjEyOGoyenBjY3BFT0hscDg1V3U2U2FOdkt4enZS?=
 =?utf-8?B?bGNnNGpmMHBzSVN6YktMd3VVM3g2TlRwMEIrNkJldER0bnVuWEZaY2JSVkZz?=
 =?utf-8?B?TnJGYnErVCt3WWlWZW1jUWhkbzNLL014b0N3WTVNNXh6d21PMzlvMXMzMlVt?=
 =?utf-8?B?T2w4SDhPZG5xc0lKL1ZxS01lNERtSTZJZlh2UFEzWER0eFV4VGlhK2QvZU0w?=
 =?utf-8?B?bmZoNG9vNkYwVzd5dTBQclk4YjlWNDBpM3dBNTNnQ0tvandoQld2MmxEcStQ?=
 =?utf-8?B?ZXB2WG15c3gxNHBxZXBkaWhwc2NtQ2p3czVzcWRQSVFJaVl4WVlBdERoQzNy?=
 =?utf-8?B?bC9KbFJYVFdCVThRSWtHekxWSUkxcEl3OTMybHdvTTJFaEV4MDNvK3dGdnRC?=
 =?utf-8?B?bjR0clB3N3g5Tmh1cVlNbktSSi93eXVFc0d3RFBUZGNqUUI5MGNFZitrVVFE?=
 =?utf-8?B?dFAvS2ptelZpcjJmVlpuV1hvT0hRYVJ5ZHdmbWlkSHV0SVAzMlRhNDBlakd5?=
 =?utf-8?B?SkpScnJsMkYwSGNzaGZESi81eU5Uc0tJQi91UXhmK1B0c1RuUGsxWXEvOGR0?=
 =?utf-8?B?NUJOTjYyVDZTdXVPNEJWdUJyc1dYcVN3ZTgrbFRJTU1WcC9uR2VRNmVTQlM2?=
 =?utf-8?B?WG5HOTh5UUduNkF0SG5MV2hENm1HWmhaL0lvbnVNT2RlaXlrNmRXaC93bWFi?=
 =?utf-8?B?YlRWeTN1SVdheWVxdHQzMXc1NU01bTYrTzNteDl6MStIK2d4Q01CdlF1bmNS?=
 =?utf-8?B?b3Z2WU9BY0E3R1VpVjdvMkNvV0Z6OVh1OWpTVGJNVnVXY2xaR20wYVFwcTV6?=
 =?utf-8?B?K2M2dGFrNlViSngxemZKeVp5ZnN2eDczb0hNZWpxL1dqZkFqTEV1SHowOTVZ?=
 =?utf-8?B?S0kyRTU4UlliQzFMOFFSUlBvUlpiOENCdHRUb2Zra0VnUDBUcEhkdjBtT3NC?=
 =?utf-8?Q?ya2zW6Z0YySAaeTLZCd80xw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99afef81-656e-4b52-b7ae-08d9bef0d59c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 10:59:43.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5t8e9VOrdWXOvS2DlEzhFhKgn34e6UhPkeTqxCIcyeawyf9uGB8FS8lfhods+tjncMV3rsvu58fkufLC6YnBkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4603
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 09:16:04PM +0100, Christophe JAILLET wrote:
> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
> open-coded arithmetic in allocator arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> Use 'bitmap_copy()' to avoid an explicit 'memcpy()'
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
