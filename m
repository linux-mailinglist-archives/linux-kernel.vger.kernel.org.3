Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DC64F1F08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379585AbiDDV6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378968AbiDDQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:12:37 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4FD2CC83
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1649088641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GRLTYo8naBWGzCrD9pceDWUcri/W/2RAv8i05WI27Jo=;
  b=EKoJuYlatoejkYC3gmUVrvGEn98SiwYnHynJ326cgoqhlKQOY9vuQEMs
   9aAysX07Koqa5L9C5jS7OQE0Pl1iO3coBJp6QeypaP0/vbqLU38rsjIhu
   Xbt2XaMLxOMmB8PCvx9tNSkv9emaH0RO85Scj+cZZrZEb7MdVzqQp4rgf
   w=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 67389236
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:0HCR9KOQbLXc+G3vrR2Wl8FynXyQoLVcMsEvi/4bfWQNrUoghmEBy
 WpOW2yGPPncYTH3fYhwOYnlpktS6MfXy9BqQAto+SlhQUwRpJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdleF+lH1dOKJQUBUjclkfJKlYAL/En03FFcMpBsJ00o5wbZl2tIw2LBVPivW0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pGTU2FFFPqQ5E8IwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Zj
 5YQpY6TShcVA4LcwsdaDitfGCVEMvgTkFPHCSDXXc27ykTHdz3nwul0DVFwNoodkgp1KTgQr
 7pCcmlLN03dwbLtqF64YrAEasALBc/nJo4A/FpnyinUF60OSpHfWaTao9Rf2V/cg+gQQq2ON
 pBCN1KDajyaICRKHnwXAakBp+T3iVf8Sw0G9mKs8P9fD2/7k1UqjemF3MDuUszaG+1Wk1yeq
 2aA+H72ajkANdecjyLD/36ji+TImCn2cIMUCLC8sPVthTW72mMXGDUSVF2mveO+jE+uHd5SQ
 2QQ+ywzve0x+VatQ93VQRK1ujiHswQaVt4WFPc1gDxh0YKNvVzfXDJdCGccNpp276faWADGy
 HfO3I75Fx9soIGoZmLH1fDJnzS5PRIaeDpqiTA/cSMJ5NzqoYcWhx3JT8p+HKPdsuAZCQ0c0
 BjR8nFg2ux7YdojkvzioAuZ227ESo3hFFZd2+nBYo6yAuqVjqaBbpfg11XU5O0owG2xHgjY5
 yhsdyRzAYkz4XCxeM6lHb5l8FKBva/t3NjgbbhHRcRJG9OFoSPLQGyoyGsiTHqFy+5dEdMTX
 GfduBlK+LhYN2awYKl8buqZUpp2nPC6TYi4CquIMrKih6SdkifdoUmCgmbKgQjQfLUEy/lja
 f93j+7yZZrlNUiX5GXvHLpMuVPa7is/2XnSVfjGI+ePitKjiIquYe5dajOmN7lhhIvd+Vm92
 4sPZqOilkQEOMWjM3a/zGLmBQ1TRZTNLcut8JI/my/qClcOJVzN/NeKmuxxI9U1xvsN/goKl
 1nkMnJlJJPErSSvAS2Ba2x5aaOpWpB6rHkhOjcrM0ru0H8mCbtDJo9FH3frVdHLLNBe8MM=
IronPort-HdrOrdr: A9a23:eqest6BuTFlOG9PlHegCsceALOsnbusQ8zAXPh9KJiC9I/b1qy
 nxppkmPEfP+UsssHFJo6HkBEEZKUmsuqKdkrNhQYtKOzOW9ldATbsSobcKpgePJ8SQzJ8l6U
 4NSdkcNDS0NykBsS+Y2nj4Lz9D+qj+zEnAv463pB0NLT2CKZsQlDuRYjzrSXGeLzM2YabRYa
 DsgPav0ADQHkj/AP7LZEUtbqzmnZnmhZjmaRkJC1oM8w+Vlw6l77b8Dlyxwgoeeykn+8ZjzU
 H11yjCoomzufCyzRHRk0XJ6Y5NpdfnwtxfQOSRl8kuLCn2gArAXvUjZ1TChkF2nAic0idvrD
 D+mWZmAy210QKWQoiBm2qp5+An6kd215at8y7BvZKpm72HeNtzMbs+uWseSGqC16NohqAN7E
 oAtVjpxqZ/HFfOmj/w6MPPUAwvnk2ooWA6mepWlHBHV5ACAYUh5rD30XklWavoJhiKoLzP0d
 MeeP309bJTaxeXfnrZtm5gzJilWWkyBA6PRgwHttaO2zZbkXhlxw9ArfZv00so5dY4Ud1J9u
 7EOqNnmPVHSdIXd7t0AKMETdGsAmLATBrQOCaZIEjhFqsAJ3XRwqSHqokd9aWvYtgF3ZEykJ
 POXBdRsnMzYVvnDYmU0JhC4nn2MROAtPTWu7ZjDrRCy8/BreDQQF6+oXgV4r6dn8k=
X-IronPort-AV: E=Sophos;i="5.90,234,1643691600"; 
   d="scan'208";a="67389236"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln8NwQmTGpTO9gXBK4YFfTXf533oIY6t+MaR/f24Rj+WJMV/JyWUMB/ZW5cIzwZQyEOlFobZc+S2a6P7jzQupW9VrAUCONMEkiLbwCt4kiGEC68pgYOOCQydmToOraA6MDJZ6h7kv68xV32iZDd387Iiao5db47zhWIE9DA0IFN+GcA3MwQx2RvCMPynOEdyggOsKcMmzfCIN/HAfFSO9taH142px+GsHxnF8QcIPS51pAaGXM2KCaTm0OlCZ7dYirG0IPj/eWDZr7TcuWQ15pm7iam1B+H2AVgor0uhu+T+6Qvz6oX2M6FRqB6aviKW/WRjPvs9wKssUE2F7lteHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRLTYo8naBWGzCrD9pceDWUcri/W/2RAv8i05WI27Jo=;
 b=lL6fxHm8b4iVXNH4pHyw4ejUTwqAPSapf6eccNLpdN3zRko6zdURzlJxJu50Pi0z5FX2oUwiYh6czmgVEyYS6IaE/2QHRxbV7kGsvHADNjiUMudp2B/Dyk+AmZ41ueqLaol/UN5Y7A7sCUwZN2E0S4xDTvr0RBHyWF7NwP5dwJt2FRDw36CWSWYtZT8oZN8axhRgZbOWHjxUsiHtPvaZ11MuEljHDH7Fr5gXNMPw6dopX0GIOPpxXNDlbdjih2K+B1UvIT4Z6/l6CxudeW/3aYZSd3dI2+mPj+mRXwAnYlAZs1W9lMV9OkX8BW1wSc4uM8X0ZRHsH3KUYCu44330cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRLTYo8naBWGzCrD9pceDWUcri/W/2RAv8i05WI27Jo=;
 b=sDdgTifht56URzgJOKMNPUyRu2yMR/fa/9WukN9YdB2SVNqGMn9j89vc6hqzCvhvDx/U4LN48sZkYWSq6hew1Q01enAbtbT+ol0+ZwoknH2ZTGM8iAJUEQJbLlMe4m6D3PcpZ9M1Tvp8k07dChXxKZ3R2cUMWJeLeoKXd/dANaY=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [patch 1/3] x86/fpu/xsave: Support XSAVEC in the kernel
Thread-Topic: [patch 1/3] x86/fpu/xsave: Support XSAVEC in the kernel
Thread-Index: AQHYSB0mkEEVqJLo6kOlt2IWq+wf7Kzf7NEA
Date:   Mon, 4 Apr 2022 16:10:38 +0000
Message-ID: <11c10899-da35-f0bf-51f6-41210e234c95@citrix.com>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.598704095@linutronix.de>
In-Reply-To: <20220404104820.598704095@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe90d371-1344-4f30-9f28-08da1655a8b3
x-ms-traffictypediagnostic: CO3PR03MB6773:EE_
x-microsoft-antispam-prvs: <CO3PR03MB6773805372B356A7EDCD3AE6BAE59@CO3PR03MB6773.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwWnK0Ofl/b3rrvolf+rpDLa+OaSVSGH0mF+8pE5E0uYQfkL0TrFIWnLl/T6I/14ecql1yfZ89/zMnG0NUZYnSPLbrZ/V4yu/Zm9i5ph+ivZ1K8TubhsMKcx4Zv2Dhs4iwYY8UoG7d/Wu5fXRtjk+1cYumgviflgCRuK53ehvAL2Z8uXHYHak80/JJ1BXu/TutHRFFeSyNJhor8PNcsjWaXp8Y5acke9ZC1UgBcIr/Yi4m/xn97Ctn+O9JioHmfU0ygX3/Cc/3DTUZ8jYYV2TEnJDejWcUo+0tgpRAaBojvP3U4dcL6T03XvJdaSbnws4ik+OqSgS9FsOor+R5ACS0o3nUGrQqOu/jji5OrRJgjDJVo6++TB+ZFlhF/QbM5vLrjWbJF32qvBmmirHLvKJ+z6A5XO2yUKrikhTdEPHsBIiy+KAZLJpii2307ZuDgTqGMEj5O7iWNPQ3L0pZDFXR7N1THizlpMJRWTMYZKC3HFwNn4pvSNu0kD2C0R4UIyVooUI40yqjH5mL8imz1H6+nhTWXeu7ikdQJf0rFiKkBA4Jd1dGK/gYpeiMBmSlsre0Wi0RakOfiyRIyMyKdy4kwtcvdNCWQZXe/ywIshMKOU/kIbN9FvxNBrdd8Dt/Hk36oXZ/sRKv8EnO8N/6z2la/TZNf1ZXpfGPLaCF6Ng3UT+OwSLTeUhlk9szAyLcGcM3YC5Z9RPeAnsvOB+Cezc550bMNd4VI7FSWPTLmtaV0LNWIgrcmbLqkAsb6Djnl/3AZMVjF07+RdDmL4khS91w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(2906002)(91956017)(6512007)(66946007)(8936002)(36756003)(4744005)(54906003)(66476007)(71200400001)(76116006)(316002)(64756008)(66556008)(508600001)(6486002)(55236004)(6506007)(31686004)(53546011)(110136005)(8676002)(66446008)(4326008)(186003)(38070700005)(122000001)(31696002)(82960400001)(2616005)(86362001)(26005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0ZacEZkTDMrazhhSy9xTC96UUhKWWc4V0lyL0NmOVlFWUYrckd5N2tYeTRi?=
 =?utf-8?B?eVRvTXV4WVZta2cxRy84VWJ0a2dEWURYNWVWRTRTMkxhOHVYNmFVZjVsQzcz?=
 =?utf-8?B?a2pGSmtNcllIeGs4Tis3SnNFeUJyQ0h6TThReUR4ZFRVb1V6RHVFVk9lTHEr?=
 =?utf-8?B?SU5MdmJYMExaS1FtZmpmc0QrOHE0aUFBT3NJQStIRC9hQW1TMnhpSFNGUEll?=
 =?utf-8?B?dGxsaHlkc3NTMDcxVmo4VUhvOE1GSVM4UlNVRGdCamFTQWlhQjlsU0FRTzZF?=
 =?utf-8?B?dXBPQStyTCtnWm9YcWhDT0VpdnI2YitvOHRVRElIREUzQkpxWkxOOTFucG9M?=
 =?utf-8?B?M3FwS09rSEFTWG8xVHNxalZJMlM0T3UrTUdKYVFianFjUHZCNjJkTjNHZHd2?=
 =?utf-8?B?QjVoUVZDSW5hSFQ5d3g2Rjc2THdBYkdmaXJCLzdPSWZBa0tlTjhMb05HckIx?=
 =?utf-8?B?TGpTV201VFlsMzRkcTROOEkyWlVYZjZlcGZuK055UDJKNEFSSnYyaW9aZjBZ?=
 =?utf-8?B?Z3ZKSmo4V244bDA3SXROMVhENFVVbk1hRGh4c3RzY0Y2Rm1ZTmxrL1E5Mzk3?=
 =?utf-8?B?ZDdyNDgwdUk1UFVtaDZSSlh0M250clJHcWh3VEZlMHdtT1RBMWU4Q0JQQWNk?=
 =?utf-8?B?THhvNld2UjIxUzFScmhmV2paeHRWbUJMc2NWWjZiVkRYRWREdWRaT0lPWkVL?=
 =?utf-8?B?aGRrcnVqZzRRVU1aYktwQTI3RERpczNGbHJrdnpra1pXeHM5RVQzUS81UEho?=
 =?utf-8?B?c1dqMTd0RWlkU1RzRFovYU90NWN4UGZEdHpNWHE4L1BYRGE2a0FROXdtVXhE?=
 =?utf-8?B?UWh2b29mbERJQmpIODFQbFV4Y3NLL2V4N25Vb1BkRzNUekZBaU45bS9zdC93?=
 =?utf-8?B?enB6dzlJYzBRZFRUTDk3SStoZUFKVHUwa1MwODJqazFNbE0yT1FkdkJOTHha?=
 =?utf-8?B?cUJZVGlaZ2FJZzBpd0pZb3lBTFZXMWhRSEdLNVIrUGp6Z3c3bktMZjc1S2k2?=
 =?utf-8?B?OXR6Qkp0Q0cyRmJ2T2U1akltNElGbkNmbVZOWlNRWi9GVlpPQ2l3TGhtOWMx?=
 =?utf-8?B?TDd4czRMaTZKZnprSEF6dGFEMGRoeGNKYXBOQ2wraVJQcEJURzd3RzRoQ2s1?=
 =?utf-8?B?cnJxc2M3Qit2cDgyUXdRR2xhRDhMY1pFUkJOaWI1MVVBU3RPUmJhVXExMmVN?=
 =?utf-8?B?OHM4N3d3aVRZOHI1Z0xDWDZxMUFYVUtOa1JWNHBRWXJkNlYrbmdYYlZhQ05k?=
 =?utf-8?B?TllRSlIvdXF1cjdKSzRlY1Viam9URFFLOVMzaUZ3MS9qelk0Q21mcUk0OHI4?=
 =?utf-8?B?OWJrOXlXNERNZGVUVWp0WHVxNDV4UzlLOFY4d3hId1NrenVCRkNrWjFrNVFn?=
 =?utf-8?B?R3FCZ3c1SmgrQVo3RzhqeWJ6elRRZktkTUxzSDBpZ3g0TVJ5ZGpGYk1sVUF6?=
 =?utf-8?B?WThYYmxZamcrbHkzNEdSQi9sNDFkUHBwL2xrTVJNTkl4d2ZoSThqaWhvL040?=
 =?utf-8?B?TGVMUmlwaGdJbE1nK2FWSUNUTzBhWXBjaEI2K2R0Nm5HMFlLWldmSjZuZHAx?=
 =?utf-8?B?ZGdrYVJYNlFJS2JpcHVJMDdqWXNGQzVKNlcraUx3NlZoa2QvU2RRMy80QzBB?=
 =?utf-8?B?RTdMdEFacDQ3RGFVS0J3c1BVbTQyWVl5QjVqTzhDNkhJUHNPdTFhK0o3ZjhY?=
 =?utf-8?B?ckEzMzVsMFBZWFR1c0laOEN6ZklKZVhoY3VnRm8rWjNQSFQzd21yUitSaWZI?=
 =?utf-8?B?bEhnUlA2eHhQMndMNEpYd29Oa3oybjlpNlp3cEJ4UE5hTHFnTVdUSklxeThn?=
 =?utf-8?B?QUQ1Wk5FQlVRR2I0REUrc3dNNUF6TzVYRHFvM3lSdkxEVWdaTk1JMitkMkQv?=
 =?utf-8?B?b3MxK3ZCK3J1eS9vQStSM1RwRjNUNXZmYXhHNlNtcUprb2dDMGxnYmk1c3hM?=
 =?utf-8?B?b0lheE43M2hQTUVpY080MVdyd3ovYTJ0SXVBVzQrd0IxaFhFTnFHekdDQ2U1?=
 =?utf-8?B?TnNwemRxcnpONGpMbHg1OWtsMmNZWk8vNVQxTmZJSkZGT3RNQlJFcVQzSFpp?=
 =?utf-8?B?cXNNZkNGaiswc0ljOEw5TFdPazJNU3Zza3RsMllMZitneXYvcFFoV0hOZ2cr?=
 =?utf-8?B?UTBpcWxDdzk2Z1RqQW0zMW5NdEVUS2Q5VmZrRFQ4RlRDRDhVRzIxaEhKdzQw?=
 =?utf-8?B?ZlBPVDVTY01LUXIrWGgwS1ZRWitmakhnQ2tYYUNHSXpqVHJKYXdCdUhhd0Fi?=
 =?utf-8?B?cnhNZmE4bUYwTFFSOEozbWh2K0JSc3JpWVZFOUhwL2gxSEFQc0lyMHJIcTJm?=
 =?utf-8?B?MTUrcjg4d2Q2dElkRmRsYmw5TDluT1FPR2xKdzQvTGtCZ0pDMzFpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80BC52A25CE33A4385080370023C879B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe90d371-1344-4f30-9f28-08da1655a8b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 16:10:38.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWUWXN+LGksLEOojtJjpeIQrZSyIW86LffVF2XUSlT8P2DcEeBtjg08eP22AGKpHQmFZolTwWd5kNBnY3zNwZ2PJLrs+55bmZqPA+ShzsEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR03MB6773
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMDQvMjAyMiAxMzoxMSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiAtLS0gYS9hcmNo
L3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0
YXRlLmMNCj4gQEAgLTYyMyw2ICs2MjgsMTAgQEAgc3RhdGljIHVuc2lnbmVkIGludCBfX2luaXQg
Z2V0X3hzYXZlc19zaQ0KPiAgCSAqICAgIGNvbnRhaW5pbmcgYWxsIHRoZSBzdGF0ZSBjb21wb25l
bnRzDQo+ICAJICogICAgY29ycmVzcG9uZGluZyB0byBiaXRzIGN1cnJlbnRseSBzZXQgaW4NCj4g
IAkgKiAgICBYQ1IwIHwgSUEzMl9YU1MuDQo+ICsJICoNCj4gKwkgKiBXaGVuIFhTQVZFUyBpcyBu
b3QgYXZhaWxhYmxlIGJ1dCBYU0FWRUMgKHZpcnQpDQoNCiJidXQgWFNBVkVDIGlzIiA/DQoNCn5B
bmRyZXcNCg==
