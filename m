Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED1495166
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376597AbiATP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:26:14 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:30071 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiATPZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1642692357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oZCrScRDBgh8Pd9gcAm2rgv73VeKhvxpTW12O6u6imQ=;
  b=M53zbSzLfeRqHrj/HpMqrTedEpcnB8uTJ4FQaL7piF1jENDQ55zAxPkh
   63UraIL5vpqF6ec7ZyCX/vaBgqryQ8Cp6XmfZg54JKZW9Y0vyrBdarQ4w
   REdt5TcELmz/buIYbFpJ6W9SNNAkEWqFW+A3tozq3UZ2BXc4tdJKTUv+N
   w=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: IgM9Y709QG7niDNvpnI6yGC4dsolLavDlSpUITUJuY6BKJrhms4GGisULzHDX2XJ3vofg29rEZ
 IfHFaMb0hnUKe62QoxdrdrXZr3szRbH0flrx/5hFK9ATgeyjMKwLHiRvSRrf971/VCy2N5vBEG
 e2ntOQmzsJyXBr8RB72ga82nibXKde7+J0RFBooqKsdaohdhF3+gxsHEKGuM4okV4No2imYxxW
 JDXmLCFmfhjiLABDhbzARGARJr98hS8IWSb9Z95D7XbHBEhMMLGXx9m/W2WzNctIJQhdGVNrH9
 qlf0oaiSjEkyJCIrvQe/x+Bj
X-SBRS: 5.2
X-MesageID: 62409434
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:oWTX4ak9vZfsYTYcglg7Ri3o5gycIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJOXGHSOf7cZmume48lbY6+o0tXvMCHzd9nTFdkqSxjFSMWpZLJC+rCIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BClVlxJVF/fngqoDUUYYoAQgsA180IMsdoUg7wbRh29Qw2YLR7z6l4
 rseneWOYDdJ5BYsWo4kw/rrRMRH5amaVJsw5zTSVNgT1LPsvyB94KE3fMldG0DQUIhMdtNWc
 s6YpF2PEsE1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXee0v0XRYRQR4/ttmHozx+4
 NRPrMeQS1k0AvLVnv0BfjZjPgNPJLITrdcrIVDn2SCS50jPcn+qyPRyFkAme4Yf/46bA0kXq
 6ZecmpUKEne2aTmm9pXScE17ignBNPsM44F/Glp0BnSDOo8QICFSKLPjTNd9Glq2pgfQa2CD
 yYfQQtCXC7yTA0IA0UKE58mvdmnnnLtdAQN/Tp5ooJoujOOnWSdyoPFPNPLd5qKTMNOk0Cwo
 mPA4nS/AxcGOdjZwj2AmlqmnsfGmSL2XtJUGLDQ3u463nWQy3YVBRlQUkG0ydGph0j7V99BJ
 kg8/is1sbN05EGtVsP6XRCzvDiDpBF0c9pIGsUo+R2K0Ozf5APxLm0FSDFGQMYruM8/WXoh0
 Vrht9nuHz109rqOVWia6KyXvBu1IyEeKWJEbigBJSMB4t/+sMQwgwjJQ9JLDqG4lJv2FCv2z
 jTMqzIx750RgtQMzL6T5k3cjnSnoZ2hZhI64hX/WmOj8x9jY4ikd8qk5DDz9u1cJYyUSl2Au
 nksmMWE6u0KS5aXm0SwrP4lRe/zoazfaXuF3AApT8JJGymRF2CLfIJJuxF8elpVbd8CYCPET
 3T+mzJI+8oGVJe1VpNfb4W0AsUs6KHvE9X5S/zZBuZzjohNmByvp383OxPJt4z5uA11yPxkZ
 8/HGSq5JS9CUfwP8dagewsKPVbHLAgazHibe530xg/PPVG2NC/MEudt3Ldjg4kEAEK4TOf9r
 4c32yiikUw3vAjCjs//q9J7wbcidylTOHwOg5YLHtNv2yI/cI3bN9ffwKk6Z6tulLlPm+HD8
 xmVAxEEkgSm2i2bd1nTOhiPjY8Du74l8RrX2gR3ZT6VN4ULO97zvM/zibNqFVXYyACT5aEtF
 KRUEylxKv9OVi7G61wggWrV9+RfmOCQrVvWZUKNOWFnF7Y5HlCh0oK6ImPHqXdfZgLq5ZpWi
 +DxjWvzHMtcLzmO+e6LMppDOXvr4yhE8A+zNmOVSuRulLLEqdgzdHep36Zpeqnh63zrn1On6
 upfOj9BzcHlqI4p6tjZw6eCqoaiCexlGURGWWLc6N6L2ePypwJPGKdMD7SFey7zTmTx9Pnwb
 OlZ1aikYvYGgExLo8x3FLMylfAy4N7mprl7yAV4HSqUMwT3W+04enTWj9NSsqBtx6NCvVfkU
 Ey45dQHa66CP9noEQBNKVN9PPiDz/wdhhLb8e8xfBfh/CZy8bfeCRdSMhCAhTZzNrxwNI95k
 +4ttNRPs160iwYwM8bAhSdRrjzeInsFWqQhl5cbHI601VZ7lgAcOcTRU3ak7ouOZtNANlgRD
 gWV3KeS1a5BwkficmYoESSf1+RqmplT6gtBy0UPJgrVl4Od1OM3xhBY7R8+Uh9Rkkdcy+t2N
 2Vmax91KKGJ82s6jcRPRTnxSQRIBRnf8U3t0VoZ0mbeShDwBGDKKWQ8P8eL/VwYrD0ALmQKo
 unAxTa3SyvuceHwwjA2CBxspPHURNBs8hHPxZK8FMOfEphmOTfoj8dCv4bTR8cL1S/puHD6m
 A==
IronPort-HdrOrdr: A9a23:g5GgW6OdpVkaU8BcT1n155DYdb4zR+YMi2TDiHofdfUFSKClfp
 6V8cjztSWUtN4QMEtQ/exoX5PwPU80lKQFnLX5WI3NYOCIghrPEGgP1/qB/9SkIVyEygc/79
 YQT0EdMqyIMbESt6+Ti2PZYrUdKZu8gdqVbI/lvglQpGpRGsZdBmlCe2Om+hocfng4OXN1Lu
 vW2uN34x6bPVgHZMWyAXcIG8DFut3wjZrjJToLHQQu5gWihS6hrOeSKWnU4j4uFxd0hZsy+2
 nMlAL0oo2lrvGA0xfZk0ve9Y5fltfNwsZKQOaMls8WADPxjRvAXvUqZ5Sy+BQO5M2/4lcjl9
 fB5z8mIsRI8nvUOlq4pBP8sjOQpgoG2jvH8xu1kHHjqcv2SHYREMxan79UdRPf9g4JoMx8+L
 gj5RPWi7NnSTf72Ajt7dnBUB9n0mCup2A5rOIVh3tDFaMDdb5qq5AF9k89KuZOIMvD0vFmLA
 BSNrCe2B4PGmnqLUwx/1MfjOBEZ05DXytvGSM5y4moOzs/pgEP86JX/r1aop46zuNPd3Bz3Z
 WxDk1ZrsA/ciYoV9MOOA54e7rONoXse2OEDIvAGyWuKEk4U0i93qIfpo9Fo92XRA==
X-IronPort-AV: E=Sophos;i="5.88,302,1635220800"; 
   d="scan'208";a="62409434"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COHDNRZ9RXeyuKkGIgUtXcs0sLQncwJX5u4QmFnVYqf0It+wdkfc20emQUCKT9FvGfngU3B7xMDnU+BpBg9VOnDyq7E2ZRehqw1xvSb+8sh/M5BgfiPk4eBMnx32ZIflumhrk/nEsS306a5wFJGxXWF6/1+DmhTgwyQVUKXT/QW0RPITsyJYHC2ilDkV4Gz5QJYUvadlQr1K2uACdw4aJNjU+Ox/1Q09+rS1KtOFjyWy6pNAhjy4v6KB7Oqje2jO0MzTn2fJ1QFPKL/VKXfmse0Fh5OZwruqRzyFODnojMdzFbNTyNstQjUHyHn/ayQDlPG3b49QfwASyhw+2UT9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VvoRpfnAFYjA56B6n0lZOMr30iQW4q/VSNlk+HRrAg=;
 b=NBD47KVivOyYrfin8ktorCM0qumgleZcp6JcwQQo8gIwx59pG21S6xqoZen2UVGioB3PHzIhJN+kl+CE8+d5r8zvxJigXKmBpXj9Db9dppJo0DBYwl/luJCxlWz+bX857wzFRou2dtLfjN188ANH4Y4wpSm5Pmywhe4POrF/v6MkAivTRHZaznVWPGndHt+jSsfpSZF/C0sgaTmJjTjuTKYGMob4VFpl5HcLcxi563q6jFGLEBlhXZr/toR0HyraLGA9prsqhUAeuIMX5iyZrSjkHZiIfRNVN/wJGmn7T/W70QwqplWht2sArqYfZwk4N8YmzOYkYfuHyHp0tXg/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VvoRpfnAFYjA56B6n0lZOMr30iQW4q/VSNlk+HRrAg=;
 b=JlO/zJY+441RswCqnMCEPAUkufzSqTVh7DDO4ErHmx/JUGYv5fVUrhdg7lwMgoZ6v6i8Hto+BF0eh4GAJbWFhbk6qnvoDek/KwQQoUUwxiAilJxKQw95CjlGW3Hi3UUU1/GCofXwekA33hll5V0bJKe5IjxY3hJYZysZhWX85do=
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <xen-devel@lists.xenproject.org>
Subject: [PATCH 2/2] xen/x86: detect support for extended destination ID
Date:   Thu, 20 Jan 2022 16:25:27 +0100
Message-ID: <20220120152527.7524-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120152527.7524-1-roger.pau@citrix.com>
References: <20220120152527.7524-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::28) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6df1d34-5b7c-4ae6-3a02-08d9dc292366
X-MS-TrafficTypeDiagnostic: SA0PR03MB5468:EE_
X-Microsoft-Antispam-PRVS: <SA0PR03MB5468F34E4907E12C9A6D416E8F5A9@SA0PR03MB5468.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0gIxID0vy/qWQVA7VE7nIEbdSfiphIBdz3GUUt/aZx4xwF160UHtjLSkOg451DdolwWHYOHwkS4cbu7P3RhnlqMcZ13QLb86tS9cLd0+8V/0j2/0/gDH2aayRrhH5syEur+92Ao9dGYc0UcTHKpNrCRc5PKT1se7LXgWnLrg4i4KhnAQYhfEIAiQA7erOjEy89Lw7TqD18GwyL2ihrwJe/GHgReA0q3e5+PIwbv0yuGQehU3VwOEathroPNaRhIrPTIfO24NVrzhfYpPzXZrwl11U6k2QubVj3v6L1lVNQuSCLhQ4OYyu0+eyoT9Yot73vOLXkYKGCMnqSOlCTuguTgcG/ItXQyJCU2dwm6sXQ79NAW+R+oImyp+AD9N7STuTF6nr7UyWxGYB3yhdxdADVPAmBxX9SUGqPorLWjv6Drbr/DNJU9cGuN6kEmZ1t2M3aemyiVoeqJa0EvI4ATzljLRKck4QDObARuKyl+cDIHLym7+RI1ffuLEc5QRKosNKB/MgtkvJjIAmrXjpUh9/7zDst70yKI48NLg+mCDqMibHhMncjLtJhgy+czDlfrvWwRu5fNmKTSzbMbFgw+1jWipMXqTyV5hkfYpiArCVT0eoTIe3jeB2eC/jAKzNpUN7UgFZL8FZ3qH0FGPS0vYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6512007)(6486002)(6666004)(82960400001)(66476007)(66556008)(6916009)(7416002)(54906003)(316002)(8936002)(36756003)(66946007)(508600001)(83380400001)(5660300002)(186003)(38100700002)(26005)(6506007)(2616005)(2906002)(1076003)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akdGV3VhbyswVHVKeVFwbnR1Q1licnk4ZVZwOVFQZGp0ajJXSlBtYnFQT0FB?=
 =?utf-8?B?NDJTTmhHR1U3eWRlVTdrRk5nRGdPYTMwRHdueXRPTkh0UUh2LzJWOUxCcFlS?=
 =?utf-8?B?Ym9PNVBxUE8ra2hvalJyS3Z2TC82KzRFVUNpVy9oWFg0UmNnc09nL0NzbmVJ?=
 =?utf-8?B?S2hqSVFUTFhYTDVMeFpyb052VmVPYU85UUI2WU5RWmdzTTFUdmQrSksrTTJ0?=
 =?utf-8?B?VEhEMm5kOXE3Z0F6UUZxUjRId1NIMjZSdnB1Wjl6NElkNGZlL0hKcWtZUGpN?=
 =?utf-8?B?dVBEb2VaQWxjeHFZcng5djNuK2pYQTgrbUpWWi85c0ZYWExsNlU5YnJmUk8r?=
 =?utf-8?B?QVF5ek1JaWRycnBGamIzUXNlZzhLWG1jYTRhTW1pb05VNGk0NDB0NHBiN1c5?=
 =?utf-8?B?ajNneTVQSThUU3FQT0pRdlNFZVk4TFBMM0lXdVFsZXR5WFg2MllPOS90QVFD?=
 =?utf-8?B?UU9CRStwc1F0VG9kaUlhL2huRERhdTR2ZUUzSzBqUlBuelNodEdjQStBTWNH?=
 =?utf-8?B?a1BUNVM2ZHZPbW9ZTlpSOTBvTFN5VDJpUkRTL0JTakV4NHErZnRLcFVPODNp?=
 =?utf-8?B?K2NLODBWeEtuZElnK3ZJTTZOcG51bXYxaFMyZVFrMlh5anptRE9yRWxZWTJ2?=
 =?utf-8?B?MnZQUDZlcjVUd2xSMmFXTVhhZ054MlE4R203K1lMTEdZZWxnK1owanZId2hS?=
 =?utf-8?B?eVFodGFpSHJyYTgvcjVFRHhSYzZZWUNSMTN2TUYvWkVmZ3JlTmdEM2NqNFc0?=
 =?utf-8?B?TVhuc3hubHpqZlhjangrSU5NUW0wRHc5STVyekVGMEg2d214bmxaVWw5bEpu?=
 =?utf-8?B?S0RLbzR2MWQ2YVgyWTgyTjFJZi9keE1GUWZkY2NYUUFZZkMxdDIzQ1E0Mk9Y?=
 =?utf-8?B?empNVk9LV1p5NFR6MlV0RVZhTHJ3d3d3dUVlenlvV2RmeE1JSWZoU3ZXVnZz?=
 =?utf-8?B?eDc4L0IvekN3WWJuMEhRek1OTVRJcEsyaXNNZlE4c3NpYXQyTDc1Zkgyd0ZI?=
 =?utf-8?B?ZG5JMXF5TC8xOUUyWnF4S3BJcmVzaTFSYTZjK3ZzUzd6MnBJZ2lhU3VUSnFS?=
 =?utf-8?B?eDFBRi83VTdyMVl4S1pOL3VEalR1ZWpNNVpGcThBTWI1d2VsbldadlB0dWJW?=
 =?utf-8?B?N20wU1hXdzdlcVh5SGpTczlUOXQxSGJyZWtsRzFLdlRJcmtZQ3Y1OFlqa0tF?=
 =?utf-8?B?RUJ6dUZaeE4xR0xZamJ6MTZjYmU0ZmgzcXVhanBMZ2NyZDR4UWI2MUtrZDB1?=
 =?utf-8?B?MndtNzVNL1JNc1RmNjVpYlBFY1VMNlMyVm5sVDlwajdpMjNGVEhucXFudTdF?=
 =?utf-8?B?M0MrSEY5L2xvR09KVHBvbE93cURWMEdoblZHdktpNlhyUHhWd0ZDMUl1eTFZ?=
 =?utf-8?B?L0kvZ21ET3Zaam83L1JONmdLcHhZb3FnWHJvSGUyL1Z4aWRSRjI2UnliTy9Z?=
 =?utf-8?B?YTR5NHBmaUFPYkkxZnpNQjQrL1RlTExNQlhRK3p3VHJUamRiSFVLRVRjUStM?=
 =?utf-8?B?U21sbVhNTUxlY1BrZ2lIdUxrVVErTFAvd0k2djZZWmdMRm1JOGVyOURBUzg3?=
 =?utf-8?B?bzg2dTB4MEJpaGdCREFpdmRoQ0wrRzBaOTZIV1lrUHcyOGw5Nm5tTVpDSmw3?=
 =?utf-8?B?NG9Hb1VBZFBDZzNpc2h1NGZMRDZBZkNwaEI3T3Avb3l5Z1h1NWZUNnBQRmIz?=
 =?utf-8?B?WHFUVFZOWHVWbUt0R29QYUFoVEY0c1l1eUx6OHhhaTB5bTUrcTJDMEgxYUVs?=
 =?utf-8?B?Z0tNR3dsTVBmYk8wQ05HL3BualpEaS9SVXVNeXF4eVZGdHRXNzFxbnZSVW0w?=
 =?utf-8?B?ejBvdytaVy9rcVMvT3RhRXBBNEdQeEpvSCsxQmFhanlGUlY0bkRGaTdUNGF0?=
 =?utf-8?B?MWVuK1J1OHFYeWZNYTkwamVMTkw2ZzhDVkp1ejdCNU50a3JjNW1hTjdVcnhQ?=
 =?utf-8?B?aHhsckpHQzVaREc5M0Q2WFVQL3JqYlNJWGZ4cmFuQ1ZCNVR3OG8xWk9FMmtR?=
 =?utf-8?B?SDMwbmdvdEcxaHlPeXZqcHlBY1NYZHNzbXVBb0RkeTZzMTVLOXBNMUd2aTg3?=
 =?utf-8?B?ZDBJOXRCRmUrMVNHUXBXa0p3WkVTSmZaNmI1b0NOMGR5T1A1U0ZKSzBGeUtx?=
 =?utf-8?B?N3gxczNqVmpSN01ZQnplYi84K0xFNU4xb1NzdEZ0UWVLajJKZ0ZNUFJ5TVEr?=
 =?utf-8?Q?xWysdEGdMisF9Al5xg6P7cM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6df1d34-5b7c-4ae6-3a02-08d9dc292366
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 15:25:49.7494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPPXgv1rAw2QFPz8qeNYDdgq2YDYqwkt9HB9PEs/kBJi6B5nvbhzAgsrahrychUkxbzUuI5Ic5w04iT9p+Kb2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5468
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xen allows the usage of some previously reserved bits in the IO-APIC
RTE and the MSI address fields in order to store high bits for the
target APIC ID. Such feature is already implemented by QEMU/KVM and
HyperV, so in order to enable it just add the handler that checks for
it's presence.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Must not be applied until the public headers are changed in Xen.
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/include/asm/xen/cpuid.h | 7 +++++++
 arch/x86/xen/enlighten_hvm.c     | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/xen/cpuid.h b/arch/x86/include/asm/xen/cpuid.h
index a9630104f1c4..78e667a31d6c 100644
--- a/arch/x86/include/asm/xen/cpuid.h
+++ b/arch/x86/include/asm/xen/cpuid.h
@@ -100,6 +100,13 @@
 /* Memory mapped from other domains has valid IOMMU entries */
 #define XEN_HVM_CPUID_IOMMU_MAPPINGS   (1u << 2)
 #define XEN_HVM_CPUID_VCPU_ID_PRESENT  (1u << 3) /* vcpu id is present in EBX */
+#define XEN_HVM_CPUID_DOMID_PRESENT    (1u << 4) /* domid is present in ECX */
+/*
+ * Bits 55:49 from the IO-APIC RTE and bits 11:5 from the MSI address can be
+ * used to store high bits for the Destination ID. This expands the Destination
+ * ID field from 8 to 15 bits, allowing to target APIC IDs up 32768.
+ */
+#define XEN_HVM_CPUID_EXT_DEST_ID      (1u << 5)
 
 /*
  * Leaf 6 (0x40000x05)
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index ab8171cbee23..0c5b0ee3a02a 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -254,6 +254,11 @@ bool __init xen_hvm_need_lapic(void)
 	return true;
 }
 
+static bool __init msi_ext_dest_id(void)
+{
+       return cpuid_eax(xen_cpuid_base() + 4) & XEN_HVM_CPUID_EXT_DEST_ID;
+}
+
 static __init void xen_hvm_guest_late_init(void)
 {
 #ifdef CONFIG_XEN_PVH
@@ -316,6 +321,7 @@ struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {
 	.init.x2apic_available  = xen_x2apic_para_available,
 	.init.init_mem_mapping	= xen_hvm_init_mem_mapping,
 	.init.guest_late_init	= xen_hvm_guest_late_init,
+	.init.msi_ext_dest_id   = msi_ext_dest_id,
 	.runtime.pin_vcpu       = xen_pin_vcpu,
 	.ignore_nopv            = true,
 };
-- 
2.34.1

