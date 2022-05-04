Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8656651935A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245385AbiEDBVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245386AbiEDBTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBAF44743
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KbxhK013665;
        Wed, 4 May 2022 01:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=YC6dmHuyoIui8FUHI0NhJMv7G44UAllgXxHii9rXYWhKkeRk43Wjitd2jCD21SJqxvPC
 hk0+X/qX388BqbgvvOYvTZbU1X1pZ1oDb6Cblxbhhp1mvzPAiVZ6SLsUYGloV+k6y+Hw
 fk+ElM9s4TGphln5xLdGjXx0n4ab9+ZhAAJb2ZAOO9gzdycp+/7gjfM16yhzlq1zCDxl
 KD/l+bpqGLBbQKuJbdDEZ3byDHAT1C7w4ee2p6n5cREQZSOnfWQtbYVRpPaF4eq5MsGN
 51wJY3qDXrJrePvL21uTBILju3xxwxt95rsNObIPcUJZU3nwwTCfkGNoSAcixuSPMq9d Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXR5013207;
        Wed, 4 May 2022 01:14:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FO9j2LXKzLLVeeC4oLcf+dcjjqC9gAG3YTji0kaCDGEnHdSCUxSlbFRqo/7I0cbASb+c+Tv6LHSfbEB+HjtRhNGRFn3yFQPaEZXjaXbS88YjQo167OmRhk4NEkF3lPHGWdvs5tgbORVdgDE4a0DKnQS8Dit5/jt0zJRQLGgb9F3n6gbuz4AtR4adr0cu+g7OIDE0SoCaLEid9IaAo2pnBeoHarNsEwGAX6WbNNGUvpi9IXpJHqydnv4EOU/gG3UhEzMhgnS23EXxOwvaQFYeVrof6z4s17CRoE8q1WBstNBruyodGYrLQp9IUb/zcFYYWcaX98vf/OOHX9Ck1lTXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=jb67Qz6raKaSPYDBLQnIlhQIcxcD9rsfXFvaT244jUodw2KqeW/znKJ5P0Ti9faDTfBdvviKg8iBQiTzCJmw4uvy1UM+d/WhTygTk7v8KnHchMJ/v1KvlwdvUiKb72zPzBgFLYzxKXmfOs1MB+ZeJB0qCM3+nwWyGsO9qyaw2hJSGYtCp7umE2XNREPclvEawO2ngYdf8iMcqS3vGbD+9Cd8EBfdYaqzJU8QlO19thOeEEqWWuP/Iyyiric3lz+jnzGWvLu6qBusDR9oK/Youat3iAZq7VXa4WZqGkWsv2jMUMtGrPHzxVSnqKvDBM9EIJNVSQSdYToqT0RzXIpNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=LEdVrK0VRFCzdHIAoQL07h0o2MM83dTm80uyrcsymHKfwEWUjxJhtD3ehqTDQHY0D0wipbdjiI5OoqbM890iFpE3Tm8PprnxL9Ajiznsk8UusUc7cV9hX0uDx8OoczNrx81S+3/4oamyS8DTLNtR5b01FbYoRoESG2KOFkGU2hI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 62/69] mm/pagewalk: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v9 62/69] mm/pagewalk: use vma_find() instead of vma
 linked list
Thread-Index: AQHYX1Q/SJO7rpg9QUi7NTxYRXPxXg==
Date:   Wed, 4 May 2022 01:14:05 +0000
Message-ID: <20220504011345.662299-47-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cd1eb58-daed-4221-f7e2-08da2d6b76f4
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB26882E3FC8E1D81932D09A3EFDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: miYt+0rN9MAm7REGR3ba0kMOeN99nQ+36ZjLGlFDtqtM6eCc57/DklpLqcYEfUhKmfty1tShrEGayoJ6d2c7lChFEh5LaUV3zNmsNcbKm143TVnJnE3kvC0Tqj1HdpVRyoS1HypIoEdjzi16u9qf2YHCZCPK2umIZvZNaipfbaqSBP7GbbPC3srD5Inz/vry5le2V9UZSYQS8VhXfvPJqxJLJ/DM1gM7gVmvxjTh9+jfxWJrCixNMB/eLU5tLApweaVRI2U0SnDr+CJy7JBeGUwBzQt0C40vvYQggjJLEyCxLcAz0iSMnsg4N9C9xSMnHP9ubfWqcBhAVDOBtFMfd0mT/2qN99xyUQ3ITU1mCoRoHpxBu1UwYosqKx4nyPKLA1RpglhYsstzT/hjedG8Uu6IpZC7E1Y0aXvUUKXdE6WUEeh89dHl8q6V64+d64xc2CdlWGIiIsHFATAi4QJuPTAqvP28Ye081OQ6yxeJpCVTr0b8S4+U5FQ5SnDTw2mAJ21czL+Hnze3pRb5HyRqDEreVhTl0je8mVFSWh/BGrLSTXR2Jw5ZLenyNRPlJBTd2p/m5Pa3yMrOiLPNtO4Gd4GI7jpCx5+eFgMGN2jiNkroZzxRqtv9V6WkGmpWdYL+vMjJbF8fHZTvs6xcNxdPDMH1A7u8Vk466oulBZ986G7oju0Hec33Aai7W3SPkcnWwfQ9ELK+NHXpfoiXlTRGIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(4744005)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i6No9725Q7kI1vKAhCgkkjQERyQ2afwoQZcojZFbHpGzWxGnQ1eWYIqRkm?=
 =?iso-8859-1?Q?hwBOJ9zy9sLytrgUJShZUMZ+ouE42X9feZBXfDXTnxC4cszxPHh3d1Xzq2?=
 =?iso-8859-1?Q?AATQ+w4R8+SPFFngTA/raHy+sfUdtpY7Inh9Xh/iJ8jW6DM0Zg4C2XzKg/?=
 =?iso-8859-1?Q?+CChuZJmQizK15qjLNc3XmWYaEMItUj3CPeSHYnMsaapg6BUYPdRLHZBlU?=
 =?iso-8859-1?Q?P9OS23IS7fPc6+4JC2lbnrwZ6a3Sty4a4uH4aD2O+wBLu97EltQPjY2iv+?=
 =?iso-8859-1?Q?tT3xV8sENtMOlhEbZroVyB/cO8+QTRN0t2n+y8nmYwvKHh/z9JDUJUD8ew?=
 =?iso-8859-1?Q?JDUiy0uvQ3zVO29e0CNUMFySG7GY3Kaf/1RycLETdBy88aG2Zuiw109JSk?=
 =?iso-8859-1?Q?Aif3/W3Geh278ViX9T7CqmdLiew08gwQT1VZcO0BBRmC9n2K9iexVNkCjT?=
 =?iso-8859-1?Q?8bJx5HIDN6tas/gL89QLI2RqGvLeMPgricnS+I+EA/rAnTEyu7ccL8niGd?=
 =?iso-8859-1?Q?Edn0C8W9Dri32atm5IUzZpyjPREvyWsybDpxQ/OFU3hxiFF/tFQvUBtrvD?=
 =?iso-8859-1?Q?dEj4t2ynCUhzmdGwm8VmxLWIjvTwQlpC/MxAuKddKtij8+JDLy5qfBHQBs?=
 =?iso-8859-1?Q?HUhJxc246AFFvfeq11g5oTgeRUsH6e5eGrG5Pvi/sOZ36/9jwkjT7Mrjo+?=
 =?iso-8859-1?Q?J5ulh7YemykuiLoF6ozyHv72DzWWYsQe4EXxtlsl6i86Qe+tKXcEje3kJu?=
 =?iso-8859-1?Q?Gz7qWHpzswhNwltJPNE6FKv1OXbzNg+5Ltg7m3Uvn2q26xpy1J4cXD3k8G?=
 =?iso-8859-1?Q?FrxvrvJlGN5xofacTYIeI7bJM+LBYThCxeGViMmNnaEIHkF8tTmNhl4Gz6?=
 =?iso-8859-1?Q?3JUGAT7cREOeM08bzWqiqOMLU6qLjhAEDSVW+vZN9mPHzAa4iNBJN4Of8P?=
 =?iso-8859-1?Q?W8J2e+b/+cszzo84gbP30Ckxo89yQK5g05uoAmUTJLdfxNxTotIYzYimLi?=
 =?iso-8859-1?Q?YnTTd/EW9MP318kGBsvOzBLCyH1kG6SjE4iY8T7b5nBjma9cVDxj00HjTJ?=
 =?iso-8859-1?Q?9GF4oe7YnPtHkDrYBUSHD410RwJUc/MldaNS+EZJj/6x7mQeRmIBVKBOxF?=
 =?iso-8859-1?Q?0aGYA6zLA4dfD44SqcXB+x7olqy1qdioDjvUHEl0W6syPcyd7bfzGABsDD?=
 =?iso-8859-1?Q?RYPcAtIIkCslwk6nQPxwkP6xVnoOYoAoVWkBdeUSoe6VDOEgPFyuhrGMcJ?=
 =?iso-8859-1?Q?vtw91hDqbaNupqnpsbVW7HSIn0KRep2o0GLrH7OdT31lqgmMA8yCo4UJo2?=
 =?iso-8859-1?Q?DVckg4joN1NCJAksy90dMg6xVlepJ1snmSgWNnOXnoR2hYGaJMXaGlvV5c?=
 =?iso-8859-1?Q?gjoNjo1G9rSrvUXbjWMlQph/4U/ZK+y8mM/jvGBVyFxUWkv9WCpbfDkPJB?=
 =?iso-8859-1?Q?5vLUZvJkKh5oAo4fmdqLF9DQOX2oNXDVeOQ8Gbbzk6sDYmPx3Wy+wgD7Js?=
 =?iso-8859-1?Q?WgjK4FuCG+pSAsDpisUjqQae7tomtCBIl+ef5PsXERYuqPEdx41fo/0hH/?=
 =?iso-8859-1?Q?wP+vhMABIQhenmetFNMbDFmgJNcLRfCxgB8TR5TdPyX+ggXjORvrbodF6r?=
 =?iso-8859-1?Q?2534qSDpyVGGpyhxbbQKzxnUtbxusUpdpaYZ6MYf0bgFNuR9B3RFVIUckD?=
 =?iso-8859-1?Q?uaAceiEP8ER88FuBXjXKjWg9diQ/wjc4Mz9ThJAe2Lxbp9ZON2gVs4Oh33?=
 =?iso-8859-1?Q?cE7pJYc3XEAHW1HJd8IkiIZoAWB7bVvCe2lbr+sDZz2i81MokeW5x5jw75?=
 =?iso-8859-1?Q?Wp+n796H4V83u14bkFtmMlLFjN4qt1w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd1eb58-daed-4221-f7e2-08da2d6b76f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:05.6417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpaAWascy9Ts5Ah05fu86UbW3bHNEaQSQQrS2KtL/FvxoIajNSZNgLvxn30XZllsYjDWeVErwJ5Xdl5pYayQxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: EJlrWDK5HvYwhGhk6f2sZ2EkjzXmP4Sa
X-Proofpoint-ORIG-GUID: EJlrWDK5HvYwhGhk6f2sZ2EkjzXmP4Sa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

walk_page_range() no longer uses the one vma linked list reference.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..53e5c145fcce 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.35.1
