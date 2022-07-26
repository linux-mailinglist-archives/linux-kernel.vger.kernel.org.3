Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B1E581373
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbiGZMyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbiGZMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:54:07 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10091D321
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1658840044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dFaRabSKndev9DC9KfboEKdbF9TpCd7ahiXeOQrGxsk=;
  b=O4TpbPn/1E9P/+avxV3q905UlvESEuZ5lTpm3YMjbPyPlfnW3KDnFCDc
   x6WM/IsFCRPlYktWnmu+nq27WZjGkhdHGzXNIxazhw5rg7SYIpij3qB10
   45RIvuOMvYJ4b1+YSa9zLWkGPXQP5FRzmpgN2Sty0XcxZwcJOyfwHaREX
   s=;
X-IronPort-RemoteIP: 104.47.74.41
X-IronPort-MID: 76641071
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: =?us-ascii?q?A9a23=3AkGEYoKu2DWOwSwSvhNlrJ3A/h+fnOphVZqnMB?=
 =?us-ascii?q?8mfNqXej3nJ3QvKv2leTKMbkwGeOzwh8WQpuxkUZlUow8LJOHL7U+NTZM7qJ?=
 =?us-ascii?q?n8VHBlAg2A48ibQR3P6SI370Km1TSmZBW3y2k3ZCnoXK1cNFikj83MAtXxxo?=
 =?us-ascii?q?8+Y4up2pc+6+s4zPv8AG+C1OfKjAOt5z5f9fvgUpZumOr9CtYNSASi8cNTQO?=
 =?us-ascii?q?hJABq/qblXiaTWknx6JFtSlN6bSgbYvlBnN3YQacKHDSj9ImolLw3WqSWQyz?=
 =?us-ascii?q?OTbStNuO+Q578XZLFE4g8dXKo8dfDUvaXErAc2G1SGQ6y5cJj6TTKxdRPDDr?=
 =?us-ascii?q?7IjIx2PUCy9V5KLXWB/gaxuReT5fe4NBGpLWYSCzOLer8dRexH2wLvW9ZEJ5?=
 =?us-ascii?q?kjRR5GpRzKuAiwOgVLMcUMfSoK1P95i8L1q7jeuwVE1Y/YlBb2ad4MKr7Jn/?=
 =?us-ascii?q?8Md4DS5k6Ry1STVhPfqm2utP7UO+UZFsZJSlmeH+1ImkGAUA0ztnuKVz9xZM?=
 =?us-ascii?q?Sp4Mem74GlqzMQFIILHBHKxOp8tEnlDdm7hj1eXw54I2eQRkO1tTlHGcmnnL?=
 =?us-ascii?q?Ms5DiONzD1YK0FrcCZMbk1wdljv6Kyslgm40v0HO8NWHH+QU6xJl0BIMlDIC?=
 =?us-ascii?q?wvdxn0q7B3rm69sXspydwxjK1XtDM6sAEWoIIHmCPhkhKN6mlwXfEwuV02dC?=
 =?us-ascii?q?Bfb6OcOwp1az8AAQW8o1vDm/Ku6jM7r9MCz/rO04dMMpoOeHL5aX7BtnwCtz?=
 =?us-ascii?q?VFUFDDwO2uib2fm74Zn1isDiXs75Mc6TNtbknmBXkPITTVspVHlNDDzmEbn/?=
 =?us-ascii?q?UNOZpBo52VZN8Pz7srIWsLBUj5RVn6G/mZLtXaRNJAwUGsCdJxu2i07OhgXe?=
 =?us-ascii?q?M1Hu8AZzzcGtvP29n2+MaPFKAlUwWii20HhbPMpYBEsiZNEoOgRq+ar1ll5+?=
 =?us-ascii?q?W90fRrdGuEeLNxnM+AbqO5Hobb3mN4lsV7uC6vKGaYbOMLvHH4YBi5hqH/g7?=
 =?us-ascii?q?ZSJDD57X8ZyueKvZ8tdME6IbtbN2ojkFAVDpzgx5BMCT+myP8CbVGB3/f13j?=
 =?us-ascii?q?yKCpMSkeXERi1Agxs4vcoq1NHScI8s6mUc6VQ1bXn0DgujlNdS5FcsNSPXoI?=
 =?us-ascii?q?+kzWC4ovJTTm8rORCcx6/V/YlcMXX2Eg86sZGsEsvxlsOikbVKR/NOkOfRWI?=
 =?us-ascii?q?/eOQtGtF+0YTGVE9eBzoEZVwQtiRhrJn/X6TVsLfsrm7AVRKShk9NuDJFNwE?=
 =?us-ascii?q?6iG+seRbVwvnVeOEntXyamPWVuy4FcfWq4z3EhAM6OBApuAP0/iPZrw7alCV?=
 =?us-ascii?q?YwhIZRLR5c2Xzml74WTrqPcGVKet5VIslIM6WppQArmjm9pqa5WX0L/l/VAW?=
 =?us-ascii?q?8iEgT9q+geJfh3VOZ9oAgTZKsB/ILaJrFAWCP+hE3rYWPNQ3oPvUMMztKSEs?=
 =?us-ascii?q?nMOcuzsmZQH00lJlYzt0YPGosJ72laBls90n8RMLNOO2TBT6x0YTlXGsvzvT?=
 =?us-ascii?q?Jmvpkzfpn1+SKcPbXOmap/Ag5pfHflvX4C5U7tZ4fXUZ8vQIubTjUW0bjvgR?=
 =?us-ascii?q?V77pAOm1S71hfaZJK3XAa5YU5VNFuDbBQt7HRkQfSmaAi4Ct7b9gNiPP1yYj?=
 =?us-ascii?q?G23jsaad3WhEDDVPsj0qkp9Y7ko0XUa/b9YA5s+wIJuiEh9oD17AsTxJak24?=
 =?us-ascii?q?C9BpncbjENEyYP5CI+abFO9zyqYYDhTT0TP2r68lo9KrkOAe5VrWfkrJiTit?=
 =?us-ascii?q?Yu685Vn+oKVyZQoRMGYHYOybSQlLph2GdZE+oR+edai2wBWDsSkak5sBBmSo?=
 =?us-ascii?q?UnSmX44b/zNwE0xT3O+Cji6MOEFfGf8Z0mJIaBPDPZfCGjuaW3AEagZlaAp5?=
 =?us-ascii?q?fDln1HRthfNeDpOP65k326FA6ptSiSWOwpFRBEXKWWEDrYQX9qzlhN+bfFpT?=
 =?us-ascii?q?9Zhm6lPmJU2HKjKVWmSDCtgZ7s8jHrlxXoI9p3TQQ6e9KpMTngiTDMDLBGRm?=
 =?us-ascii?q?8mNjTkEc3fVYLxh46uiJARSoq6VJO86/PJ/HFYBGgmO5U0TdOM+CHDaA1WZ/?=
 =?us-ascii?q?jo9zDuj/JmkGpBDRMzvYC9SCX5UlXF5nvaH7aeDtyIxJ8nYay0JlqdbEKwU4?=
 =?us-ascii?q?MlybxEIi/778+6UxuoVyZS+zpWLMsEQpOrY0WQY1Sheb0sBr0awRZKQS2PYu?=
 =?us-ascii?q?qNLsot6Nojey2Tk+qE39O0qC2I+nwLYsyfSG1eAuE6Q/tWvhv3jD0Uh9+yQb?=
 =?us-ascii?q?LVvFfIf+ES0QKkY0Nvf0OBMUlLE2CjgLv9Qktu8vJoKKzBsZzC/KuDGEstcm?=
 =?us-ascii?q?S+mB50IuM43X5n+xVIgYRcfgARPt7gnN3W5aIfM37PG05B3mf/6ptaumUp/f?=
 =?us-ascii?q?ihvz9Zt4A3u3fr008jD6Op21gVXHeFYfHoWRjRZ9DImMYe37p0011o8PvQll?=
 =?us-ascii?q?UKV0wnReijaFISieqDOWrghPEWH7r1DLgsOJZq01magghtF3NTvbR5YsVums?=
 =?us-ascii?q?qpUTQXi6KZreq6Ew4jIkrhrvaRmuYmQOlYhveDj6mDiH5EsoULX2fnj+RxzW?=
 =?us-ascii?q?1eQp5uKrGggla+1q6XeitHkcazvNfPzZsMyFyPHwBt2zw3HCtqzkn+TjVcs1?=
 =?us-ascii?q?c/FRdOdQ1Ixpz1EuRJW0DEwxux0+jUWfJD0nMPg06BRlWKpSqsr9HeqI1eZq?=
 =?us-ascii?q?lsokDtH/9twoGhmofuIeVYU3aWbrxq/fMDngrkhUOt771WCc3RrVS/ESdKu2?=
 =?us-ascii?q?zpMLavm26jMSv/tTbjrXrsJGZnBEuQ5HTFwzAm8EhfbJOGEtG1ShIwR2DVYY?=
 =?us-ascii?q?Lg9RKj95iBZcf100cE+tFWjz3pVeHvv3buEMoRn8F7S6HXYySn34bcAL8Xrw?=
 =?us-ascii?q?C3e7XQu+v5Zc6nGVV0en8BVMrRqc73TBGCcvLSp40yJubTSX7GkdBeADo0dM?=
 =?us-ascii?q?4gc16tyCitCbG6OLysgdjOmg+UU81+n39KGQrGwwVtqi8LbWsOQE9EUzEVc7?=
 =?us-ascii?q?qU96J8o0bPse/RUTBHRb+c07cNC1DIAH+x6TomI2Vo/2dOtiK8PJdhTuspdc?=
 =?us-ascii?q?vwStwyIxDgDsvJEQ3mDBUlNWnUzrk9kmNcw5J5avQdHcn7Y54+u8cvHI/GcT?=
 =?us-ascii?q?yOcaVVaDfj0T1B8pich8nOrXtAY7FwRxxoLUw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.93,193,1654574400"; 
   d="scan'208";a="76641071"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jul 2022 08:54:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqknwbAQx3Nz1DAKkG5TZQaYNDcgKQ63lC8i3kPP1vftDQrvPjqOIKQLMwWkvmM1OIjMnM4A/K8nHRyUAu/RgfUrKpKfl2v/OwbBEW6dHSHCBkmSyNrUwbJQm1FwmX64WzuMJ8bmZRnrcoybPXkRVFEDr2br+FSs0WsAj6ueUsndh3apVBsthuHYryb8R8V+y0JoEN9uSaY5k+tUAUWQwu4qGUh9pThbOFuR/NAvbPQhM2v2+NoWSWmkiswhX4DJtXcAdl+7dof0ZRKpF4AF3xBms6d3q6xq83Gz/9JsdOsMR/LCxe9quCPpEsIqgnP2/TltC6Cy5+BZqgVuTlAxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFaRabSKndev9DC9KfboEKdbF9TpCd7ahiXeOQrGxsk=;
 b=U+Uk173QCwfYckb+DCxESdr2vUbQ1+V1Sx7/a5oYYIHwiI5kjIFrsXoE971cVGE6qeTeTgvyrwO0xk/xXIH0bKZsuwDh2gbotlj9Wbz0MngT/UG+kuu2JCpGVxlLK2roqBWS9i5ICiUkTVb5P+eoAi8ESw4DtDg0Lw4V+k8WfXu2e0P+6OEP8fqv8vFyqllRcdLQVlYGuJL4h2sWgMMxl45IYWBT2mZjTzVpm1Pguv6LaTVaumwR5tSveFKPSWeYpybcd0D4JaO+WgmcugSVe/nbBB6xVs6+j8Vl3aUL+klJSpbWGPfkFKTc9SSJp0nozbOFmRddicTXZyHttRTbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFaRabSKndev9DC9KfboEKdbF9TpCd7ahiXeOQrGxsk=;
 b=P8z6LbAMnpeA+fjbjCrZulxTXxNZ8YJlAdQZXtN1O45Rqa1UryUs9CmyTLmAKEu6E03CTP/D+E2OqHiWKCjVNc3cituqINBFpsSQhmo/S/4iWsqNNLJ27mBeinP1Xcc0u5hbWoT3cQ1dBvaa7mwJv/XeRprxFxP6Ol/Dqbq1LAU=
Received: from DM5PR03MB3386.namprd03.prod.outlook.com (2603:10b6:4:46::36) by
 BN8PR03MB4913.namprd03.prod.outlook.com (2603:10b6:408:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Tue, 26 Jul 2022 12:54:01 +0000
Received: from DM5PR03MB3386.namprd03.prod.outlook.com
 ([fe80::81f3:95a3:4853:a11f]) by DM5PR03MB3386.namprd03.prod.outlook.com
 ([fe80::81f3:95a3:4853:a11f%7]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 12:54:00 +0000
From:   Jane Malalane <Jane.Malalane@citrix.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Jan Beulich <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Thread-Topic: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Thread-Index: AQHYlTod5hgtPAUSGEuMopkQlGVYGq189b0AgAImowCAABm4gIAAOBkAgARvxACAAFS4gIAKvnyAgACzuoCAAQ4ygA==
Date:   Tue, 26 Jul 2022 12:54:00 +0000
Message-ID: <201dd409-1e84-e097-c1cd-61c4d244f106@citrix.com>
References: <20220711152230.17749-1-jane.malalane@citrix.com>
 <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
 <0b5ec408-197c-7e34-28d8-7505e1f031df@citrix.com>
 <01cc9e39-242a-3cbf-13b3-cb3ecccd5737@citrix.com>
 <3be61417-6e58-1d9f-dd3c-7de00daa8d0a@oracle.com>
 <c9aafc28-e93f-ebe4-b591-0edab4efdf2b@citrix.com>
 <41198c6c-22ad-1530-793a-e557f3c09415@oracle.com>
 <b0124d4d-32c9-01d3-36e7-9890ea990fdf@citrix.com>
 <ea76eda5-2736-aacc-5256-2bee7b9247fa@oracle.com>
In-Reply-To: <ea76eda5-2736-aacc-5256-2bee7b9247fa@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dff590c5-f979-4937-0f49-08da6f05e914
x-ms-traffictypediagnostic: BN8PR03MB4913:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvV847nMrHM8hc8AV4QvIIHhTbDuIonn/mUGeeOnf6w5jIWhXOJKjl9HUXlHhNJBtCn7Z9cdL4yX8Eq8l1q28fiiOqXxd1gPeO7QpDz9YUbkJg6QdZlkViiEv6zLFkJFqMS0WgTxmc7jrC1p5W849GET/6d7n9HN3dVq61Zq9kHONtKrkxeoOV+O5Jg4lhbpoZUM0U/RpuTWATEPUkzub/dkxR4uSpGugQsRcdU+0qHtiHdlpalDmni54r8OBHpGvYVGgXOfxXcFXc65DU/c/kGLYIVsTPHQItPTjlxB8ElFNTQPWfyjWGcbbzYkIuGiDMSCz+QMzrgXzlxg21mfPf9MNck0rqEJAC+gRv5aA4Jqbygl82qVUNTezw+YchurdNAdzjo2rAisQvf0dt9os17P7vkmpOriqqy/EQbP6GCxI/G2K9e5/Q4GjTpSrqj6Hiu/Nk/Mg5I/BW2uXKNfE58WZwbcDP03qOy+tsnVi5HuInA1vS/ITxWkH0prfY8jYJ4rfX3vq4H+OQR8v95owkCniPGdPD2obznolosxwHxX0LP4xghXdlmBJC4ss0hnLiobkbs/ev7h0GXeUy/m0qBQ+J05iiyrvHLhuD5VVMBU2lQv9chfUOAoQbjrm2UeRGE2T2+G9icyTY1RRSA/44tngUMtFqOQigwmV5L3KQy41Kj96NFLuQkzfV3TEBnGYtPRYCsYg5LtyWA9dVOROR1TKL8DfMYvZE/IkTsvckbBy9RzzVSoXM6rbfTA0Kl0pJh9O+Wn9BofIMR++5pdzK5Ww3EhXYydhkiqbw2hhZ2zwKPXrTYoYKGZgGMiNICHAGcUme7hrPOUtchi60y9aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR03MB3386.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(6486002)(4326008)(31696002)(8676002)(36756003)(478600001)(71200400001)(38100700002)(86362001)(122000001)(31686004)(5660300002)(54906003)(2616005)(66446008)(66476007)(91956017)(66556008)(8936002)(76116006)(64756008)(83380400001)(66946007)(7416002)(186003)(55236004)(38070700005)(82960400001)(41300700001)(26005)(6512007)(53546011)(316002)(6506007)(6916009)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVU1SUNScmd0UW90eGl5YVlyVlR0M0JMNGRFMzM0ZTVXMmlITWdHWGZFKzYy?=
 =?utf-8?B?QURJY2wvTEUvTWFiSW0wN3ErMzVxWlYwWXhsVkpVK1pVZDlMbUd4UFBkL2Nv?=
 =?utf-8?B?NDlpcWtWM3lTUmwwSk92YVB1Y0ZEbzFCY25FbHE2Tzk1Tk5kYU9EbExraFcy?=
 =?utf-8?B?ZXRFdWZVY2hpTVpMZEc5WmU2VXo0ZS82WjJPQW82WFNET3BSalkyZXpSMEQv?=
 =?utf-8?B?a1VvaWJFeU9HRGhGeGY4eCs1RzkxclJDekpVSTJlMDJ4ZGFIZjNkaHVIM0Vm?=
 =?utf-8?B?ZlZ6cm9vNzh5bTRWaXE0V2NEbUhSL0p6TzhneGtvZUN4U1QyQmRSbEU4Zjgv?=
 =?utf-8?B?U3dsWWNEU3hCOFIyZlYzb1dGV1cxeWpZVlBLeFZiVWk1QzlpK0xRYlhrb1pU?=
 =?utf-8?B?dDdWZDZZUDRlMjJLd2FwZlJCUjRwR3ozNVRaQ2M5ZUFSV2x5OUZrSFlDdWRv?=
 =?utf-8?B?VmtpK1lrdmZpZHlJamJod1dkUFNpMUtHNUZiR3pnM1NnbnBoSGM1RHhZVGhZ?=
 =?utf-8?B?S3h5eEZBblNPbzVmQUJWamUvc3FxZjRiRkZMZGs4blpTdmMrK0ZKZkcwZlVP?=
 =?utf-8?B?YzVUcmE1eVMyOHErVjdRWnlXdzQ1K1F1WDhHL2ltNmxpVFMvS2JISUhJbm4z?=
 =?utf-8?B?MWVaa2FuNzg0TnBBa1QvYTZ1azlHTStXZG1MeVd3THNOMkF3QUlMVm1aVzRM?=
 =?utf-8?B?dERHWlUwZ05XUDlnOUVReFJENkh0MmFZRGRTd1JPU0h6L2FNc1kzTTRITTRj?=
 =?utf-8?B?aUFLQmFXdGN1M2RQRWU3aXdsSjd2WXNlK0duQ1pCUTJ5OUY2YUMzOHJIdWdo?=
 =?utf-8?B?TWRIcHdJY2FwYVVLNDd6MHkyRmRRZ3pzMVB3WVd5ZTZMV0JXVUdZZ216Y0VS?=
 =?utf-8?B?b2hndVhwUGN0Y1QvNlpPRjR5RXRyTEhUc1VlT2VvUWlVRTN0UWl1aWJBbHhk?=
 =?utf-8?B?andiTG9QQkZFTDJQK3ROWmovQTBXQWlnRGdYOERRSk5IaGpqOXloRFhUaVc3?=
 =?utf-8?B?bVdVSUN6V1BWSmxCQncveUdiL3YrMUsvRG9UUWlkY0hLMkY5cFNTZExTczVG?=
 =?utf-8?B?WjZ6VmEwc2I2bWw3Q3JxMlk5dFRTekNyT1Q2bXh1YS9NQXJ5Q1l4b3NIT3Zu?=
 =?utf-8?B?QWM4ZnlzdlRXTFFZSWw1UHJKeDdTdm9XTStOVmNMTnBwY0QwU1Q4SE1JUTY5?=
 =?utf-8?B?cEtKbW5yd1JZdk5KNzY3L0dwdExUU1BZNG81cW9pOWxUUVJVNlpQZlJxWGJy?=
 =?utf-8?B?aUY0dFdGQkRxdUxvTDBoMlpYVGZ3TUFWa0ZKOVV2VDFQdzdZblVJclRTbFhH?=
 =?utf-8?B?WFNvczVhQXFSQmdremtGbFMxZCt4bEtzMGkzbUJoYVpXeW9xTk1RNTFHL2V4?=
 =?utf-8?B?a2MyNERwUzRMeVNDb2doTnNkSzdFdE8zbU1UN2o4RFRuMlgxVDU2Q1ZCNHpm?=
 =?utf-8?B?UmZYdmJ2bWNsL2tLS0VNbkwyZ2Z3b0tuN0RYazJaTUVtSXZsNGdTOTB1dnlO?=
 =?utf-8?B?ZFBqMXVBZGRTYlNhNXhFNUxMKzJtS1hqcUJtNnlJSGVyNGJwL2JzZzZickNa?=
 =?utf-8?B?aWg3ZTF5cUNEYVY1VmV1Y21vN1lWR2tBWUZsQWZOZFoyUE80S0FjcWRJVC9y?=
 =?utf-8?B?UXZxSlBEa29ralU0L2NBdlY3VmNGNGZKcVhyTjhsNUluMXdxUjduaEJTdVFG?=
 =?utf-8?B?akF3WU51cVd5Vm5XRkNIempYaXNEZndXa1ZIeC8zam9mY2gzYkJlMFRXajVl?=
 =?utf-8?B?MWtKVmlhTEpjM1djQkdhVlp3RVB5SDdqaG9BbW9jOStHWVE2b2dDdmdLVmJJ?=
 =?utf-8?B?dHZpeVJUM3VQai9ORWN1R0kvanc3aWUrVWR5c1ExTlhxWTExbkE4RW55REVr?=
 =?utf-8?B?cUYvMmdpaWt2dnlRdDRFOHh4UEwxcmpVNHhqc00zRklVbnlHVUtlQjJSWHdp?=
 =?utf-8?B?RHYvT3dUeXE5MU1HdWNTSVRGaVVVSmxLWklzNzY4OXBQZVRZM2xHODVkWER6?=
 =?utf-8?B?OHdibFJQQjZ5REVsT3RBUmlLUVFnenQ5MU82TnUvRXBKbUgrcTM1OVFIVFVT?=
 =?utf-8?B?SkZEblRPU1NkVVMvMC9RQVFPWlgwRXNSVGhLVko2b0wrOGJ0MlByWVV4ZDI4?=
 =?utf-8?B?dTZBbThBNit4bHdQcW1TVmVpU3Vtem4wUmxkdkR1dFhmdGloS2oxQmxxMkVu?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <863A8E8A6D5F4E47A52325C15EDD3AB4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR03MB3386.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff590c5-f979-4937-0f49-08da6f05e914
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 12:54:00.1959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBDA7k5i1CwaEvNVKnz7UItS3X4fQ4PReio4KUYIkT2rmNhslFw/tvBJfzOsHDcGGvJFFNs4LIiEIQQu009IdSboIwnw2LQmOYm/eoLTgCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4913
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUvMDcvMjAyMiAyMTo0NiwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPiANCj4gT24gNy8y
NS8yMiA2OjAzIEFNLCBKYW5lIE1hbGFsYW5lIHdyb3RlOg0KPj4gT24gMTgvMDcvMjAyMiAxNDo1
OSwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPj4+IE9uIDcvMTgvMjIgNDo1NiBBTSwgQW5kcmV3
IENvb3BlciB3cm90ZToNCj4+Pj4gT24gMTUvMDcvMjAyMiAxNDoxMCwgQm9yaXMgT3N0cm92c2t5
IHdyb3RlOg0KPj4+Pj4gT24gNy8xNS8yMiA1OjUwIEFNLCBBbmRyZXcgQ29vcGVyIHdyb3RlOg0K
Pj4+Pj4+IE9uIDE1LzA3LzIwMjIgMDk6MTgsIEphbmUgTWFsYWxhbmUgd3JvdGU6DQo+Pj4+Pj4+
IE9uIDE0LzA3LzIwMjIgMDA6MjcsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4+Pj4+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgIHhlbl9odm1fc21wX2luaXQoKTsNCj4+Pj4+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgIFdBUk5fT04oeGVuX2NwdWhwX3NldHVwKHhlbl9jcHVfdXBfcHJlcGFyZV9odm0sDQo+
Pj4+Pj4+Pj4geGVuX2NwdV9kZWFkX2h2bSkpOw0KPj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni94ZW4vc3VzcGVuZF9odm0uYyANCj4+Pj4+Pj4+PiBiL2FyY2gveDg2L3hlbi9zdXNwZW5k
X2h2bS5jDQo+Pj4+Pj4+Pj4gaW5kZXggOWQ1NDhiMGM3NzJmLi5iZTY2ZTAyN2VmMjggMTAwNjQ0
DQo+Pj4+Pj4+Pj4gLS0tIGEvYXJjaC94ODYveGVuL3N1c3BlbmRfaHZtLmMNCj4+Pj4+Pj4+PiAr
KysgYi9hcmNoL3g4Ni94ZW4vc3VzcGVuZF9odm0uYw0KPj4+Pj4+Pj4+IEBAIC01LDYgKzUsNyBA
QA0KPj4+Pj4+Pj4+IMKgwqDCoMKgICNpbmNsdWRlIDx4ZW4vaHZtLmg+DQo+Pj4+Pj4+Pj4gwqDC
oMKgwqAgI2luY2x1ZGUgPHhlbi9mZWF0dXJlcy5oPg0KPj4+Pj4+Pj4+IMKgwqDCoMKgICNpbmNs
dWRlIDx4ZW4vaW50ZXJmYWNlL2ZlYXR1cmVzLmg+DQo+Pj4+Pj4+Pj4gKyNpbmNsdWRlIDx4ZW4v
ZXZlbnRzLmg+DQo+Pj4+Pj4+Pj4gwqDCoMKgwqAgI2luY2x1ZGUgInhlbi1vcHMuaCINCj4+Pj4+
Pj4+PiBAQCAtMTQsNiArMTUsMjMgQEAgdm9pZCB4ZW5faHZtX3Bvc3Rfc3VzcGVuZChpbnQgDQo+
Pj4+Pj4+Pj4gc3VzcGVuZF9jYW5jZWxsZWQpDQo+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHhlbl9odm1faW5pdF9zaGFyZWRfaW5mbygpOw0KPj4+Pj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB4ZW5fdmNwdV9yZXN0b3JlKCk7DQo+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoCB9DQo+Pj4+Pj4+Pj4gLcKgwqDCoCB4ZW5fc2V0dXBfY2FsbGJhY2tfdmVjdG9yKCk7DQo+
Pj4+Pj4+Pj4gK8KgwqDCoCBpZiAoeGVuX2Fja191cGNhbGwpIHsNCj4+Pj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgaW50IGNwdTsNCj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGZvcl9lYWNoX29ubGluZV9jcHUoY3B1KSB7DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgeGVuX2h2bV9ldnRjaG5fdXBjYWxsX3ZlY3Rvcl90IG9wID0gew0KPj4+
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudmVjdG9yID0g
SFlQRVJWSVNPUl9DQUxMQkFDS19WRUNUT1IsDQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC52Y3B1ID0gcGVyX2NwdSh4ZW5fdmNwdV9pZCwgY3B1KSwN
Cj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Ow0KPj4+Pj4+Pj4+ICsNCj4+Pj4+
Pj4+PiArDQo+Pj4+Pj4+Pj4gQlVHX09OKEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX3NldF9ldnRj
aG5fdXBjYWxsX3ZlY3RvciwNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICZvcCkpOw0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC8qIFRyaWNrIHRvb2xzdGFjayB0byB0aGluayB3ZSBhcmUgZW5saWdodGVuZWQuICov
DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFjcHUpDQo+Pj4+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVUdfT04oeGVuX3NldF9jYWxsYmFja192
aWEoMSkpOw0KPj4+Pj4+Pj4gV2hhdCBhcmUgeW91IHRyeWluZyB0byBtYWtlIHRoZSB0b29sc3Rh
Y2sgYXdhcmUgb2Y/IFRoYXQgd2UgaGF2ZSANCj4+Pj4+Pj4+ICphKg0KPj4+Pj4+Pj4gY2FsbGJh
Y2sgKGVpdGhlciBnbG9iYWwgb3IgcGVyY3B1KT8NCj4+Pj4+Pj4gWWVzLCBzcGVjaWZpY2FsbHkg
Zm9yIHRoZSBjaGVjayBpbiANCj4+Pj4+Pj4gbGlieGxfX2RvbWFpbl9wdmNvbnRyb2xfYXZhaWxh
YmxlLg0KPj4+Pj4+IEFuZCBvdGhlcnMuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGlzIGlzIGFsbCBhIGdp
YW50IGJvZGdlLCBidXQgYmFzaWNhbGx5IGEgbG90IG9mIHRvb2xpbmcgdXNlcyB0aGUNCj4+Pj4+
PiBub24temVyby1uZXNzIG9mIHRoZSBDQUxMQkFDS19WSUEgcGFyYW0gdG8gZGV0ZXJtaW5lIHdo
ZXRoZXIgdGhlIA0KPj4+Pj4+IFZNIGhhcw0KPj4+Pj4+IFhlbi1hd2FyZSBkcml2ZXJzIGxvYWRl
ZCBvciBub3QuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGUgdmFsdWUgMSBpcyBhIENBTExCQUNLX1ZJQSB2
YWx1ZSB3aGljaCBlbmNvZGVzIEdTSSAxLCBhbmQgdGhlIG9ubHkNCj4+Pj4+PiByZWFzb24gdGhp
cyBkb2Vzbid0IGV4cGxvZGUgZXZlcnl3aGVyZSBpcyBiZWNhdXNlIHRoZQ0KPj4+Pj4+IGV2dGNo
bl91cGNhbGxfdmVjdG9yIHJlZ2lzdHJhdGlvbiB0YWtlcyBwcmlvcml0eSBvdmVyIEdTSSBkZWxp
dmVyeS4NCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgaXMgZGVjYWRlcyBvZiB0ZWNoIGRlYnQgcGlsZWQg
b24gdG9wIG9mIHRlY2ggZGVidC4NCj4+Pj4+IEZlZWxzIGxpa2UgaXQgKHNldHRpbmcgdGhlIGNh
bGxiYWNrIHBhcmFtZXRlcikgaXMgc29tZXRoaW5nIHRoYXQgdGhlDQo+Pj4+PiBoeXBlcnZpc29y
IHNob3VsZCBkbyAtLS0gbm8gbmVlZCB0byBleHBvc2UgZ3Vlc3RzIHRvIHRoaXMuDQo+Pj4+IFNl
bnNpYmxlIG9yIG5vdCwgaXQgaXMgdGhlIEFCSS4NCj4+Pj4NCj4+Pj4gTGludXggc3RpbGwgbmVl
ZHMgdG8gd29yayAobmljZWx5KSB3aXRoIG9sZGVyIFhlbidzIGluIHRoZSB3b3JsZCwgDQo+Pj4+
IGFuZCB3ZQ0KPj4+PiBjYW4ndCBqdXN0IHJldHJvZml0IGEgY2hhbmdlIGluIHRoZSBoeXBlcnZp
c29yIHdoaWNoIHNheXMgImJ0dywgdGhpcyANCj4+Pj4gQUJJDQo+Pj4+IHdlJ3ZlIGp1c3QgY2hh
bmdlZCBub3cgaGFzIGEgc2lkZSBlZmZlY3Qgb2YgbW9kaWZ5aW5nIGEgZmllbGQgdGhhdCB5b3UN
Cj4+Pj4gYWxzbyBsb2dpY2FsbHkgb3duIi4NCj4+Pg0KPj4+IFRoZSBoeXBlcmNhbGwgaGFzIGJl
ZW4gYXJvdW5kIGZvciBhIHdoaWxlIHNvIEkgdW5kZXJzdGFuZCBBQkkgY29uY2VybnMNCj4+PiB0
aGVyZSBidXQgWEVOX0hWTV9DUFVJRF9VUENBTExfVkVDVE9SIHdhcyBpbnRyb2R1Y2VkIG9ubHkg
YSBtb250aCBhZ28uDQo+Pj4gV2h5IG5vdCB0aWUgcHJlc2VuY2Ugb2YgdGhpcyBiaXQgdG8gbm8g
bG9uZ2VyIGhhdmluZyB0byBleHBsaWNpdGx5IHNldA0KPj4+IHRoZSBjYWxsYmFjayBmaWVsZD8N
Cj4+Pg0KPj4gQW55IG90aGVyIG9waW5pb25zIG9uIHRoaXM/DQo+Pg0KPj4gKGkuZS4sIGNhbGxp
bmcgeGVuX3NldF9jYWxsYmFja192aWEoMSkgYWZ0ZXINCj4+IEhWTU9QX3NldF9ldnRjaG5fdXBj
YWxsX3ZlY3RvciBPUiBub3QgZXhwb3NpbmcgdGhpcyB0byBndWVzdHMgYW5kDQo+PiBpbnN0ZWFk
IGhhdmluZyBYZW4gY2FsbCB0aGlzIGZ1bmN0aW9uIChpbiBodm1vcF9zZXRfZXZ0Y2huX3VwY2Fs
bF92ZWN0b3INCj4+IG1heWJlKSBhbmQgdGllaW5nIGl0cyBwcmVzZW5zZSB0byBYRU5fSFZNX0NQ
VUlEX1VQQ0FMTF9WRUNUT1Igd2hpY2ggd2FzDQo+PiByZWNlbnRseSBhZGRlZCkNCj4gDQo+IA0K
PiBDUFVJRCB3b24ndCBoZWxwIGhlcmUsIEkgd2Fzbid0IHRoaW5raW5nIGNsZWFybHkuDQo+IA0K
PiANCj4gQ2FuIHdlIHdyYXAgdGhlIEhWTU9QX3NldF9ldnRjaG5fdXBjYWxsX3ZlY3RvciBoeXBl
cmNhbGwgaW4gYSBmdW5jdGlvbiANCj4gdGhhdCB3aWxsIGRlY2lkZSB3aGV0aGVyIG9yIG5vdCB0
byBhbHNvIGRvIHhlbl9zZXRfY2FsbGJhY2tfdmlhKDEpPw0KPiANCk9rYXkuIFdpbGwgZG8gdGhp
cyBpbiBhIHYyLg0KDQpUaGFua3MsDQoNCkphbmUu
