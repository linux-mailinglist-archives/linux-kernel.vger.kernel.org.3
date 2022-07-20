Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D3F57ADA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiGTCRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiGTCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:17:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F643E74
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:17:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1Ktts002392;
        Wed, 20 Jul 2022 02:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hPnUc4YUfuaGtUKTX+zTMZ5LFuL9w74PMBIBon1j/RQ=;
 b=clzjqjIGktGUCb7P+1AmJMgl35i+LMIOXOm0tRzd5zHQF7/+Q8I55IlR8JO9hqOsz0Q9
 Mlka3bcfmFpq9od6lOla87p2YgwXJE19KfFXjAseXxkBNfY/vi/CzTQQno/UAzNPYp8M
 /hHjMT500F6FhMB4Y0TphSq/tKPNFvOM+5gQRS0Nab2TO9rX1gpwekuvkOnEKgLCKfDi
 BBSFzl8wKRy3No3CwACWbtyfsXLfagF3GpcSKkInxJqMamjK1cZ0+SjMn2UDzYp1misq
 K+95X/lrRmuyCliEPvYVjLjf+MQ/qiI2qv+9323fvL8N4yAo4Z93hCvBADMQmfm0PyEe Ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0rIv1002688;
        Wed, 20 Jul 2022 02:17:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnukc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y88YJyXSixbCxum1hOI9bVr18i8AtVY0bm5a8yDLlmbq3tuH5FAPKpt/k1odPbeJISwZQW+tehN7DdDKmvBFoIwisuDLR6Y5x/4wyPDLqeUOCOPLr0aTZkrNjyGI7VXknD7FrlEcfPwFEmeJCG21v4gU0VvYcmAiLxkT41UZjRvWrt4yGqFfzxcb4LgZg7exSNfqP5zOD41MS2jCCkLiMerAY/imTn+vinJwc+l8VAfJdSFgBVng0OQpKfJ/S+nItWcetOFpyJf/m21MNz8NbG83jchmqfaT+e6wkgYL+EHmnel6xZBfbrDafOGeXJDvO0uJ0odtl89/NhibYkO/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPnUc4YUfuaGtUKTX+zTMZ5LFuL9w74PMBIBon1j/RQ=;
 b=K/j7jMChQFkCCONEkmRsGMT4A1zmDqWqtRjnu5LeKdoo6qpW5CPx8oiuOrGbbAWmJrRAy40AbuadzDWHSdsUdbgEmp6Bti76fCdrwUs1xTDJ4scu0MdkYDXZUfBMc+Jx5mQj7CJJbVd5aQSYzkn0voPlQ0gk09MYWrt4HyfznxvgKLcEo42STH7fLEqA987FwlSc010TGjZKuSUxYWfL3mn0Q/YqXtlJU90N5rLcXWufkTIgV1MK2nkV/HlzrL9bkFL0IuJF8dAvgriBkIDCig3YifzVQHaMEfHXBC1wVf6iPsqkOhDMj9yE+c5f605wCZcxtqwui1IlfqhmlJsEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPnUc4YUfuaGtUKTX+zTMZ5LFuL9w74PMBIBon1j/RQ=;
 b=EDX7T94NG7N9O2MLxzemu/pYbpfUoBnZmFivy2OcfSWlBgFQPt79ok3Fy6XhKhhvKbT9+groQWf1mScSsIobAS83zYxToyoEkWs4+C0Ij5lYtcQpB/RJSyci3ewY7udw+VhsMxr1MvIlkZa7zzhJRaE2E7hcOBQLtIpP+2BAyG8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2889.namprd10.prod.outlook.com (2603:10b6:5:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 02:17:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 02/69] radix tree test suite: add pr_err define
Thread-Topic: [PATCH v12 02/69] radix tree test suite: add pr_err define
Thread-Index: AQHYm97iIKjZokIzp0KwjDNpNwul+A==
Date:   Wed, 20 Jul 2022 02:17:39 +0000
Message-ID: <20220720021727.17018-3-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ef09266-9612-42da-c839-08da69f6056a
x-ms-traffictypediagnostic: DM6PR10MB2889:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VD31G2iEMutPqyjDswNWQGuojcfmPOxUXgv2F2JzDmRZ05/DBuFFoQGWIbbKgGzB5pEW+aG+rvBBfuMvJi8tjiJCVAFWRPfExw9xHlph+kbEHJJAQpOn869+pHyPo97d26Pw680/I6SxUJwfUT5WCoAs3xsqvcj5kavvBQMm6xkPIDLh2KUyH+vfJNJ1KxW06PRpQ+BdRhq+a0v4RAGwrLBcAGVWwJoZJg1MDAZ+jkHWKu1TlvodLsK+bAMhlqzHB7K7G/Ds1MYIDC+ptWAD2eAxCcb/GjdFFzkqZLwuVf2pHpsR1gLdkW/EwAIS21LLZ4ctFixVKTwsrH1WzOmegPo5y/BP1xdsPvsolJL74ZRL+Np0c61UVnhpn0XBRMoek7wab2biP9BnK/GdMBU5wLD92LWSDaDzOKSZR+5JohH0FuoqUVbalelEq2ZvVMpBRKuZxjSn0bWXh3mO5NE81u6kaoxxMQvfWvoictnnD2lxs/gjSjcbRQznX6h6c5mV+3JEXF5v60v2Ph+vYfveJ0IWezljtqoaZtYMwm1NvkGJFYn2TOKzZ2brFuMEG3DyWp6fu8gT+BQVk+FaBpRf4+J/TNHASYq4kioZLkz4etBGiW2jDv+Wah9vxCMMvlMUYdWhzmO0cDgE/2RMTWQLgo9Q5jUNIzNTDZXi2SkGZDO+PUUXGY82ZIflv0xQGdszya1Uw23JqziNxz9KMXADcrQRJmP2r2bYXHdMFAgrhwtWPgYFoMZj0vpcnhPNjYrFNxQcH/cpCkEihGwhVGJ4a5QRKqHBrX8mhO7BLP2aqq5T7V0Un1juwy40yu1GSP81ZfvrdpwYct5n/nmBYDyR26Mn7Re/23bggtMOv2Fk7OzX7URXF1qfRmp1omSynd32
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(366004)(39860400002)(8936002)(5660300002)(76116006)(44832011)(4744005)(64756008)(66476007)(66446008)(66946007)(66556008)(8676002)(4326008)(2906002)(91956017)(122000001)(38100700002)(86362001)(38070700005)(6486002)(966005)(36756003)(71200400001)(478600001)(41300700001)(316002)(110136005)(186003)(6512007)(26005)(6506007)(2616005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zv63cXw14yTyMfufsMrp7HV4ZNS1vxwmp3mXs33fB6TVbO/En9HctfP+i7?=
 =?iso-8859-1?Q?GWlz3OPO1xZK6ThfIyd6f9s3j4kgBxo92TWP9ouH2oSj+gjQwPbR8jPEfo?=
 =?iso-8859-1?Q?8AnTE1aKs/wLd1T/gbKY9kWvdk69p15lgxJ1g70IDz47xnB8rQMPpNDkMh?=
 =?iso-8859-1?Q?BDR8FCz1JJAJfpSAhRbhqhYVeVFcXw8o+LaycHpbAA/poN7zfwAe4L+JtU?=
 =?iso-8859-1?Q?8FUQUoUXUEriZ1SV2MlP2ebN/+OymXBdhgwsuo2g1D5p2GXY2V6Iozn9z6?=
 =?iso-8859-1?Q?YIzRjfty6pkquUtPFgOjOVWjdRauDCKvNPXptRfbuSZJFi5WXzCkVVmsRW?=
 =?iso-8859-1?Q?wY2i51y78p3YuCSFfSPfkqSc+rqL2O2n3VWBmy520I9bvpKCInOR/4Da4c?=
 =?iso-8859-1?Q?Vw8O9YOAjIGOntQJckSzMjT2VMUmkL8jFaeDcrFIRu6nkDKUVHAtYAa/ql?=
 =?iso-8859-1?Q?cM52HffPYrCsX7NNnjo97UldsIvSGoZStUQgvwBjjm5Wvx9PioSlQpWhrh?=
 =?iso-8859-1?Q?PAQUpJ+vCB08Z6ObtEKnndOkLkCfaHexCVrMLEVUw3lG57eryIFV0aHJKL?=
 =?iso-8859-1?Q?1L9mTjqMO83g65s/N50Bi+o+RY6ElzrcA2uNXVnJQyncM7IhmGxgNZlvBT?=
 =?iso-8859-1?Q?mFsIM8rOMG6/tMpwqvXxZiDAsQj54UwuFL5jQlkpfmjW2ZHu0MLioNuUsh?=
 =?iso-8859-1?Q?TnTwqe0F4+MhTOwINP3ZdMk6QkLFzrePM+91EdQOOj6qTgs+DU9Ky/rm4q?=
 =?iso-8859-1?Q?XuOHHY1my1yhwpFaH3ml4eZ4L4NTB/zMjQnwFw2tiDZtPw2ax6nEkCFKj8?=
 =?iso-8859-1?Q?QpdTe6/ke2qqO3840Hlp92Q39OaeLF93mtEvd8nxVtRhOY8FbiR0bfnzW6?=
 =?iso-8859-1?Q?OVSIDM4wqpEJAGs5Bv+JIY67IR6/ij6fT+muopXNGNmuPJzZNn3k2uKRPt?=
 =?iso-8859-1?Q?Ka72xQYe6VMA1HdQ3E6sN6g0UFQUQX/tmUmvq84xY3aVO6XqgASVcAHeOO?=
 =?iso-8859-1?Q?KZI1+TDX8B6EjpPyjUcoFNDC4zZncb7amCSkb0TxROtTL/Mf1i4JXleQLZ?=
 =?iso-8859-1?Q?Js7JMURIEJo1z/dWCvV4C2TSPpXZ5c3hJPabvgeJsPBHETKvK0DzNbZSnH?=
 =?iso-8859-1?Q?jr3+htrYz42j/Y9Q8EfpKda5eOaiJDQpd6wIX9/bxfNzdXV7fQVDk9K7AK?=
 =?iso-8859-1?Q?26un2WmXGQAUGekqy4/8JtwA9c6i70+kC5b89We2Qr8SHScQIWMMdioRzc?=
 =?iso-8859-1?Q?IHVgD2wfoHPSn0pL6nlyI/GiyOETRiHPMw6k2KlbY7sIc5FYjlwivPYoJJ?=
 =?iso-8859-1?Q?N2jk/Cn3/7JVJXYS0uKAC5DbMqwFimDUHX5tKAT6xJ5kTa9rE1EPe3XXUB?=
 =?iso-8859-1?Q?tyFNIq+wqcbvf/7SEw0X4UxHROJqXf8CyHjbVdzaI2BaaCXbT5ZsFtZO2Z?=
 =?iso-8859-1?Q?GZg0EBCu4+s1jJIgWgmDFW89cUlH+yGnQ+mH8eL/foK2JrNRw1q0I4Rnc4?=
 =?iso-8859-1?Q?fjgRjgs1tPgHiQGbAJdJdKpQIiAXSK4xXWXYyKxPxbp02/dSav+2cdhInN?=
 =?iso-8859-1?Q?N6VTaSuvSDLgFn9cjvM/eXXq/bNv7RHCSnpcrxgOvzpPU8S+B/UNuTEej5?=
 =?iso-8859-1?Q?kZaTuXdtw2yfxH0OuBkJvNChAo02mDgQ5LqmbdujfBSNBXARGcSwznxQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef09266-9612-42da-c839-08da69f6056a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:39.6039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNZUsKj2JP2fUBAdNdsIfEhFSM7sddCmLGHjp+lRNlpe09wXomKMw8Twcog5PDFY6tqUVcsAMZGMz41IQnv2MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: cG3d2RgVJ5pJnyG5eK5iyOgPLGlL6TgU
X-Proofpoint-GUID: cG3d2RgVJ5pJnyG5eK5iyOgPLGlL6TgU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

define pr_err to printk

Link: https://lkml.kernel.org/r/20220404143501.2016403-2-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220504010716.661115-4-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-3-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/radix-tree/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.35.1
