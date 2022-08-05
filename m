Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBB458B0DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbiHEUfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiHEUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:34:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCB6EE32
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:34:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275KW9d8032151;
        Fri, 5 Aug 2022 20:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1cj/AD85Px5Bb02aVV4/IROyTuCbehjD5HKkBw/YbkE=;
 b=vIGzllFQLnF1/x7oklFkCrcEdRdhXg2J8CwD4MmuA9Isg9ilKfnsP0/83gNVsqGfC65l
 13BoHSyPQTTOAWbI1uFyRsC/G1+dVJgEqaiIRsoZfWDwLLz8PPjUcU8mDd72upWURL/6
 tBvcg/4b9o5r2ej1M1TAA5ojwkPk9bfwVMZDGpUqyACZPshsCxEougYLZcdZvsR4h4rk
 tFXG0Gp/UGELqvyZW2T/saS2Knn7NQTyouryOM6cMnRrcgI63HJRa0tNNTao0jEk7vv1
 8xvrK+JoKSEZQmEvNyWZ6VXGhz7vnMEpBWk3H9HwLZAD7kALpgWcZoEmbC6aiNEMFSY1 FA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6trthv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 20:34:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 275JOFOa030831;
        Fri, 5 Aug 2022 20:34:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu35s6r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 20:34:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPSLE7DQyPN/4gprLTMUmX2Rj/9ClCfqUbeocGlYsmIjXg2LapkjK6RXT+UU32O06CJhx8Z3biAel2KKKWSuMjqArfIKlhOYORg6aMUWwuiDUZUeuWYtAzDGNe0m+zYLZ1Z3VfcSSHBexA0LesNJGtfvauqzhj9RWF49xVdXZOUEgzbk/a6bKGTCfCamUkBdV6mPBHOnDTojb9glN1vgeqWd0ucgcwJ+Mcvr8UswHMZuYdgEwVfgNEyKgvXjSHbvdNeWhCdhr9QmVca/30OBqWUY4uyGUkq8f+47v5N5g/5hr+J3c6ctnbviCTrkQRmP08e34RDGPmGAy1PRI+32SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cj/AD85Px5Bb02aVV4/IROyTuCbehjD5HKkBw/YbkE=;
 b=Ml5fABVNXVnkz2xr2N43tdquTVI7NiQ3NFe92I1Hg1TJv2B4jUqaMeAojbHzrIEKD5FwTudr23x/u44lm0S+iD9N5BC5raV394jZWu73Oq+LlYBf5kBQvgI/ao6kIzYB9KN7sOB6f90yTMjuIhYRyURlSPFeJOEPqj1EcOFYgTIUh8li8LgB58/PiG/UWiHGeOcoZG/f0FYcaO1RxijecUI5sh9uK4jXdOVxzYZorUZRKLj8uZCUL+pwd/dKhtgYAiNzAOGJbpNZ43EG7X58uDz8ge2bddt/MH7F4qxFntxZZgdfhenbo82vSOBWBenW23XRQ7E1EZ+pbXXWNF7xpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cj/AD85Px5Bb02aVV4/IROyTuCbehjD5HKkBw/YbkE=;
 b=lJZ5IJ1u63XaWYt3OPbFjfMcMZL3pJwQo9ZFFHBe8IzzeCZkORYwsVShWzcUf4fihC+AKp9wV7xjdJjjL8yZuXFyAR511WLMAUS0F5wSDKEdxQOdx/eyPHoctyAETlEeG1IHuYU+JeSril2dpvcifGdDxW19z7/1SIg2TRT6tFE=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by CO1PR10MB4674.namprd10.prod.outlook.com (2603:10b6:303:9c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 20:34:25 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 20:34:25 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] shmem: Update folio if shmem_replace_page() updates the
 page
Thread-Topic: [PATCH] shmem: Update folio if shmem_replace_page() updates the
 page
Thread-Index: AQHYpAsmmbDT6gJKuEORFdp5TP+PXK2cXOKAgAAqQACABEZIiA==
Date:   Fri, 5 Aug 2022 20:34:25 +0000
Message-ID: <9DB4F0AA-F088-4EBF-A14C-07FDC3F99825@oracle.com>
References: <20220730042518.1264767-1-willy@infradead.org>
 <20220802174637.3bd3478d137b52ef3b67c3b3@linux-foundation.org>
 <Yuno3hVxk+rOheVs@casper.infradead.org>
In-Reply-To: <Yuno3hVxk+rOheVs@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b24663a-cca8-491f-b0dc-08da7721e31c
x-ms-traffictypediagnostic: CO1PR10MB4674:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWrHVv2przgl7ARKduU5WlMI/viYLlmir+hb3Cw8c/WglgkgOhfKgpOKTOejRPsbTl0iNNUpIW/Tg4X3IXxDUTIV6w4iXKYrbxi8dnauq6dshSw1PVlNJGo80TrfQyvkebB7jZchPOhYQCZGsTtgP3+5MYXw5WMeyrK042NvqYyGcSPH8LYDjaI+jlvOhrKQWbpEKPM87WPC5Gsljn/57AGhJVc/YROX8/iM0hH12o4s/qZByooOYt+PPt+1bT7Hl31t/Kn+RAZ7DUnTW03gFk65hWpZNQeFUrAn/pbIHrVxN/uIkHfG56bJcPSgjGbnwsaSjBwfO7qiJ2kuNJiPn614tz9oMDdjS1ZUJEkNrDHhjtpeG41ldnjNp+LVkMiJBoCtz/csPPDGHPvPgzcY3cSnFTNj4XHEZE4rlqfILe1LEusfSFgMMpXBXeT7B9Pf6DrniVfuhJdVZgk2wj9oD3IUREBg5IKo9Y9pu3/VuSsaLevEzz+0pOo5DtPyozfVoUD4JKEcczyeLgM69OwSO0FjovXkCHFScQQcxJ+v0u7ma63cFHOQNO8UFF73LRahGe200QsCvPMecEjxqVGwI8GSwu/LRs3r/GhZ2Zf1ilj6Z97Xr6PytGEnvsq8/UcaC0waesS7+h5vUeOFWg89lk5J9aQsNbCMfXSCD1puSTZGgFokmKzDjTLMWqhiCQpze2nhDkxTAo0lLca5A4ehg9ywK9JXsic+nvT5q43d6bWQPru/wADZqUDbaWKNVLGDDhUNWV5e+X0QcxpEOlHuWo2vQc67VafuTpjOcBkHCMJsvHzXutTB/4qGZlHBR+1nxfKQN5Q4YUKqqapv536gtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(366004)(396003)(346002)(38070700005)(6486002)(66946007)(86362001)(6916009)(71200400001)(76116006)(66476007)(91956017)(66446008)(64756008)(8676002)(54906003)(316002)(66556008)(186003)(53546011)(2616005)(38100700002)(122000001)(33656002)(6512007)(6506007)(41300700001)(478600001)(4326008)(2906002)(44832011)(36756003)(5660300002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2EzUjNCaTl6MUNvMUhSczFXMzRTazNRSnd1M2thc09VWWxhSjNVZkNhL2ZP?=
 =?utf-8?B?VUF5K3BZVkdPcEJodExBNlZ0V25maEtEVVdRbS8zUXdnZkxrbTgreVl4dXc4?=
 =?utf-8?B?Myt3Mnlld0JPRHlCQm5UemhsUytlRTdKcEhFeFBHdXpwaitidnhmUnp6Slpy?=
 =?utf-8?B?Qnd3KzlJQmMrQlJhaTd4NVFldFh6THZCVGdld2FYckFTMC9uTXlOVGlveGVE?=
 =?utf-8?B?L2J0VTBXMEprNWE0ZkF6VW5yb2lDbnpyS1lTOFV6TUt5YjFhWXo1N2h1VnhI?=
 =?utf-8?B?akRnd3c4bmlwenRVSmVjWGRsTk5tUFFmR0UxdmFGczRJeGlZWi8zVy8vcjNp?=
 =?utf-8?B?K3RFWE9JWm5GREVCT2hWaWZib1V1MFFoMkpNRndDZ1lucGZMcWRPSTVHS2J1?=
 =?utf-8?B?Tnk2RStBZnk2Mlh2TnEwZ3JNY0lHWXR5L1JveGlxd0Z2Y3ZJTUo0VTV4R0NZ?=
 =?utf-8?B?bGxPSjdRTjVRTVA0aVdCYzdVcUpKOVJyckIzRmY5Tm13R3JPZ09iN21ETitP?=
 =?utf-8?B?eGRHQjRCaVVCeVRTU1hKMWNZRlpWdjFkajFYVVRqVEhWd29RTHdVMGU0Y0FL?=
 =?utf-8?B?T3BxWWNqN0Q3ZWJidDZGWGg4ZEVTSjNLZ0lkUHZXb3lLMkhCcDhIWDY0bFYw?=
 =?utf-8?B?eWwzNkF6ZlJtWFpmMHZFcXdUb1pkRWhmMXk3YWQxQnYxSUZGT2xvTGJLRFUx?=
 =?utf-8?B?Sm1EaG42V0krekQxVDYxUVdkM3FsNkZLMXZ0akMwTSs2OVBzNGJ1WWpjZHIz?=
 =?utf-8?B?TisyK2pxZncwdFpSSE1CQ2ZGSU1waWJCZlZzdzBpRkxzcjBHMDBCVk9XVU1q?=
 =?utf-8?B?YzdKUXArN29hczZVNEp4Q3BOK0hFTll4UTQxWTN4NWpoVnNYdFBQVnFuYUpk?=
 =?utf-8?B?elhER0Z0WS9kMTJFMVlueUI5R205clJsWm93ZUlnY2RRWHNMRU1WMTh1WXcr?=
 =?utf-8?B?U3NnY3A3ZEZpSXVQSHEwRnMrSFNGRU55a29wbkdvQ3BNT1BkQ2Zrd0hXM3cy?=
 =?utf-8?B?U1Izb3huYVAzbzhaNjl0WVQxMGs4SlNaZTN2VXI1QmhlNElZUG1aV3NYYytL?=
 =?utf-8?B?OWhXT3JDRzFUSDFFSUpGempUYUFRVUcrbHpUUW1OeEZEclVaNUJwMnFpRkZh?=
 =?utf-8?B?Rm9tVExWTytwWG5GK3VYNE93dm5TMHgwbnFJYmNRcWpCczVrMi9jUkdxZmxH?=
 =?utf-8?B?MnJvcTY2YjFJcHhsRC9IM3Nqb3FqN2k3RWlYUVZEVWgyOHFsMjhWVytkWWo0?=
 =?utf-8?B?eWlkY0FlbVlMUHRVY2lZUU50RG1wL2JjSzFzc1NITXhRelBlbTNQNjBTSFdy?=
 =?utf-8?B?aU5NT1NMWmwyY1BhTWVpK09sRXdKNWUvaFZDYUg3dmk1b3VXS3k0cU1TWTZK?=
 =?utf-8?B?SG85TmdOQ1hla2NubVhSbDNRdHpyQXowb1pZZWVlc0xMOTRVRXNDQ0FCZDll?=
 =?utf-8?B?TXRoc21aRFVSRDBRL2xpcVpiR0g5cUlpQXVqeGRyaXJqV2FDVjNVWStoVmRT?=
 =?utf-8?B?a2xtR3VpdEhEd0M1SDFsaytGUlV5ZFhjUHhOeVZwblNQTHZiSDFMN0c1Z0Ez?=
 =?utf-8?B?ajZyTU43ZmJRYUVQVzg4aHFLVEFGbU5ucE43Q3plc2FGdGRkeDk2cHF6SjJp?=
 =?utf-8?B?RlVVL2RyaEhoYVN0UndHVFlZLzVIVFZ0cHpxamVUMnZwdVVaNXRFb2ZEYTJM?=
 =?utf-8?B?aDJ1dTlMNG9Ubmt1bmJFd1Vnc0hOa09ld2E5ZWp6RU9naDIvcldkTHhTZEhn?=
 =?utf-8?B?WWM0YlA1NVJ6L0hneEJ6b0drYVNOTVpSVmVibm9QZHBISXkyUnlRUVdZY2RL?=
 =?utf-8?B?aitGRjB6STVPWVUySGRWUmhYQXQwWDZ0Tk1qbGhZVXJERVg3QzZwb29sdjcr?=
 =?utf-8?B?b0JXK21mb0NDL0JqbW9aWS91WWNnRFRQa3JDZ2lva0phZWFzNElhQ2M4STli?=
 =?utf-8?B?N1VXVndUdW9JbWJKcU5vcEorbHZkc2Z0aEp2dUV6TGFMdlltUWlmRnhxWjNF?=
 =?utf-8?B?QUFMREk1TUJVTGV3dHRxdkFzRDQ1a2RENUhvYVJjY0hrbnJocUpiUjZCczMx?=
 =?utf-8?B?ZW1zU1hPeS9BMm9PZlJ0TWtCc0oyZU1mQ2E5dFZ6WUpRMk5pVGNJR1RaR1hr?=
 =?utf-8?B?Ykp1VFJuQ1cwQk05TVJJbWVwWXgrcmx6SExCRXBwVld4SEtlUEFYNTR0UHBt?=
 =?utf-8?B?bm9pMXJuT3BXbzEvandUSHl6dzBwejBqVE5SMmhFcU9SYmwwT1BtUm9OWWpm?=
 =?utf-8?B?cjZxdnJHeEtRMko2NjZJc2pBRlpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b24663a-cca8-491f-b0dc-08da7721e31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 20:34:25.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ue3d6Lcw8Fh8Seod0nYFA0eiewa5xV0scZ50+LWTQLO++iuFyhP8XrE3LdWpOpLsRbdhKn4IVUiBWmVwtECdo2Iq/w4KD55EXfOXX6rIf1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_11,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208050091
X-Proofpoint-GUID: WJeEJNf_nHIvlI2e4BzcK3timz8qaBR6
X-Proofpoint-ORIG-GUID: WJeEJNf_nHIvlI2e4BzcK3timz8qaBR6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IFdpbGxpYW0gS3VjaGFyc2tpIDx3aWxsaWFtLmt1
Y2hhcnNraUBvcmFjbGUuY29tPg0KDQo+IE9uIEF1ZyAyLCAyMDIyLCBhdCAyMToxOCwgTWF0dGhl
dyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4g77u/T24gVHVlLCBB
dWcgMDIsIDIwMjIgYXQgMDU6NDY6MzdQTSAtMDcwMCwgQW5kcmV3IE1vcnRvbiB3cm90ZToNCj4+
PiBPbiBTYXQsIDMwIEp1bCAyMDIyIDA1OjI1OjE4ICswMTAwICJNYXR0aGV3IFdpbGNveCAoT3Jh
Y2xlKSIgPHdpbGx5QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IElmIHdlIGFsbG9j
YXRlIGEgbmV3IHBhZ2UsIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgb3VyIGZvbGlvIG1hdGNo
ZXMNCj4+PiB0aGF0IG5ldyBwYWdlLiAgVGhpcyB3aWxsIGJlIHNvbHZlZCBieSBjaGFuZ2luZyBz
aG1lbV9yZXBsYWNlX3BhZ2UoKQ0KPj4+IHRvIHNobWVtX3JlcGxhY2VfZm9saW8oKSwgYnV0IHRo
aXMgaXMgdGhlIG1pbmltYWwgZml4Lg0KPj4+IA0KPj4+IC4uLg0KPj4+IA0KPj4+IC0tLSBhL21t
L3NobWVtLmMNCj4+PiArKysgYi9tbS9zaG1lbS5jDQo+Pj4gQEAgLTE3NzEsNiArMTc3MSw3IEBA
IHN0YXRpYyBpbnQgc2htZW1fc3dhcGluX2ZvbGlvKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHBnb2Zm
X3QgaW5kZXgsDQo+Pj4gDQo+Pj4gICAgaWYgKHNobWVtX3Nob3VsZF9yZXBsYWNlX2ZvbGlvKGZv
bGlvLCBnZnApKSB7DQo+Pj4gICAgICAgIGVycm9yID0gc2htZW1fcmVwbGFjZV9wYWdlKCZwYWdl
LCBnZnAsIGluZm8sIGluZGV4KTsNCj4+PiArICAgICAgICBmb2xpbyA9IHBhZ2VfZm9saW8ocGFn
ZSk7DQo+Pj4gICAgICAgIGlmIChlcnJvcikNCj4+PiAgICAgICAgICAgIGdvdG8gZmFpbGVkOw0K
Pj4+ICAgIH0NCj4+IA0KPj4gV2hhdCBhcmUgdGhlIHVzZXItdmlzaWJsZSBydW50aW1lIGVmZmVj
dHMgb2YgdGhlIGJ1Zz8NCj4+IA0KPj4gU2hvdWxkIHdlIGJhY2twb3J0IHRoaXMgaW50byA1LjE5
Llg/DQo+IA0KPiBEZWZpbml0ZWx5IHNob3VsZCBiZSBiYWNrcG9ydGVkLiAgVGhlIG5leHQgbGlu
ZSBub3QgdmlzaWJsZSBpbiB0aGlzDQo+IHBhdGNoIGNvbnRleHQgc2F5czoNCj4gDQo+ICAgICAg
ICBlcnJvciA9IHNobWVtX2FkZF90b19wYWdlX2NhY2hlKGZvbGlvLCBtYXBwaW5nLCBpbmRleCwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3dwX3RvX3JhZGl4X2Vu
dHJ5KHN3YXApLCBnZnAsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNoYXJnZV9tbSk7DQo+IA0KPiBzbyBpZiB3ZSBkbyBlbmQgdXAgaW4gdGhpcyBwYXRoLCB3ZSBz
dG9yZSB0aGUgd3JvbmcgcGFnZSBpbiB0aGUNCj4gc2htZW0gaW5vZGUncyBwYWdlIGNhY2hlLCBh
bmQgSSB3b3VsZCByYXRoZXIgaW1hZ2luZSB0aGF0IGRhdGENCj4gY29ycnVwdGlvbiBlbnN1ZXMu
DQo+IA0K
