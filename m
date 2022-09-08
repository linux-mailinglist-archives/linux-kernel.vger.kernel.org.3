Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B1E5B26F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiIHTiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiIHTiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:38:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305DFDBB5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:38:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJZvm013961;
        Thu, 8 Sep 2022 19:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CokDxDX3VAQUgE8fgEHG3bJTJ+RnPpCT78fhlFqKRFk=;
 b=kpjRcfxLrDUgd7ggqYD4n0S+jSo1ASHpS11lLR7eCNfvFwDHXl1eY6RUuzNpnkqPN/no
 6VKxByMwkRV1aBx3xDn6Ey0EC2WeP6H7syDL7mpeVjtgf4NT9tqFX7L4WZh/Oi4GazFm
 UZ3sv4361mj2/7WfVKtCTgJmfhy2/AFYymcZ2vdf4a4dmCDVa0M2z0wZOQQg6b9mwxfw
 aFDsrrxk0RGIyKgMFYei5tohP1BiRRtk2tTGjn9VRf17LNU+E0veYRfTQyrXT6prso0P
 SgKgWGHSoNibDpsD9dIX7rDiV2myiwvSQleTnehcXfrz7n5dXrUE7EE43SumP34k00E6 tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftvy0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:37:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288Hpxbs028932;
        Thu, 8 Sep 2022 19:37:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jf7v7bu1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nxh/JHi4Q7+WiuHk5GYKkjTU6+OSPmI6VS5638lEzRQvK7+FEGfjuL//n+cTYfLNur1Tfk8siemqj45em23xLzofSTtxpDClVWnCDk6Qusxnocu3xR6tNVTQ4P3M0tADUmYY9sWf7sPE7a/4rB+PePkFpOxD//DEzsYVGF6DN1NUvKmXq09ugbqVmM4HUqon9DHpY/4d8JU+IFrjWe9T9hd8GxZUC2hjh5U3lod0oV6Tj3w+W+QFoh8gVxV5DSOlmVixbM4zTlaos15LjZqod+nnKeHKRRJS8Q/qHZJ60N55rK6PqocTzecXElsMOZLmPthABOzCN7zweHFcb9tsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CokDxDX3VAQUgE8fgEHG3bJTJ+RnPpCT78fhlFqKRFk=;
 b=ncGFCRgcocpBGDPxcNpUh2qPYYOQr7rz09oS2w+YGlqcrZmmSDOAkvW2j0Ut4bnEmJiUFp1qGukmqbSGbgroQxWm9HBmUP22OsgQfWWouAjUK2kSwS/tPmXurlioYLIPMzbi7JzKrfF6MddfA9wp5owwa1wDfFHSPRdLtFhXC4dHl0k+LzFd6wvc7nhyfPC+toMryiYZUTp+ek2HRvqXa2zcRVj1YYrRsMYl7jeaS8ZFITc8g1UyLY86nhgPfI72auwCZIpNoGogUQMmoxc55nBKEBwpwqyIWd/oZO+d1BHnp3rBMSiM3+bRzWyCuON+H5KEP2ZIZ6muJUf9q95dng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CokDxDX3VAQUgE8fgEHG3bJTJ+RnPpCT78fhlFqKRFk=;
 b=DbAmWEjFmMYXaTOmGLS17bvcgDTR+1V+mwk/RVmVamUrIhQnXEygV3iabFjqdQFEKVyMuTUMLHmWSLJswpr+fviISGrgkiXjO/P58u7fz/vfidmgXeADjk6o9XT+Zr9ISBXcW1fNzWu+zbxiH6Z9SpD/o/wymUe+ZsH2QNUBZ7s=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM6PR10MB4249.namprd10.prod.outlook.com (2603:10b6:5:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Thu, 8 Sep
 2022 19:37:40 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 19:37:40 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 2/6] mm: add private field of first tail to struct page and struct folio
Date:   Thu,  8 Sep 2022 12:37:02 -0700
Message-Id: <20220908193706.1716548-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM6PR10MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: b0001ada-1ec2-4a3f-24f9-08da91d1977f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5YqnP7mZZGeHBmmfy8j9lIF/V9reY5DehiCIvIniaxwnvt2Ujq1QGKwK3RYvCRmxNk3MGZv+rESeXVEmzf5e1sjJGiikx6TE8L2lMMdWiPJOM6/YIuf21u0APCDp5d+v4JavQcOEPxm9c28WniHXl1O6ijwD9dCggATF8tOlI+BqUNm7S4mH2OE1nl3RFmJP2rKJP8NPQYynpKPSdT6TZt5L85yGxyIOfXIbS3HacfdSz/2PjXelSRRS/SqJEqiq4ssJmuT6KYjqPN4ccMUEkS7D6/WXsN9gO26dfPtcqv1s009sWQxbnPYGBD4q11658nT8h9hp+ZSJtPHinbNieZLu1vO/qt2sH/Krpc0zleer12yKMlhvugO+f/vG2aSe5BQH9FX1WPv0DuV3LdNsCKkCUKUmYZw2DtShkWvQmtJ/PwksOpGqgQ1pGyEDajx1WdBF2RgyMMrBAa8Bf+saWmuJga2bxvzHzQmw5KL+HIITjvSCBCqWINpiaKOhqK3jersUW3VcaoNQ+ltUjRPZTwro0N9VvuQvOZ2YDksDgtO6GuVQYOa2fbl4stLbWjyTRHPI7VnxNNDKg3OBMsoq3geARZ3TUWYqIEwpWK9uLlD9DRUALEl1CXKTSOEFJSumFmLROVNMxAw/ukK5WiW04ioYHEVCOF9CldThrBCdAT46RIPSlrNhKHokGwCgf2o0zfuZbkm92agcYi+SnNI4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(6512007)(6666004)(6506007)(26005)(107886003)(41300700001)(6486002)(5660300002)(316002)(66556008)(66476007)(8676002)(66946007)(36756003)(86362001)(8936002)(7416002)(478600001)(2906002)(1076003)(2616005)(83380400001)(4326008)(186003)(44832011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Dskm//Q+sa3eDGn991sJ3P/noJrGJgvoOrkOtiPgFmkT4vA8/4/aUA38ekb?=
 =?us-ascii?Q?2lRyItDq7d7qagixlLK22ITXF/+NX6YDqvgCp99xQWSXr9gTmAxphgOk1r2X?=
 =?us-ascii?Q?Nhm+aIg0AoszDjXG4rtMbYoiX6ndEAX7WBMOjoyUI7kQCOM5BGz8JoEwinlm?=
 =?us-ascii?Q?EM32hv4qWeQWLjh5CQZQMbi+HY3GLea9oQAUVJ5NsRpk72LjxfbxxDZvy/t1?=
 =?us-ascii?Q?Pw4r+YuAnr04/byyJMmVZ69uiNTjiUFm5EJK1SimZ6EcbwQ/ppFr1gA4f75o?=
 =?us-ascii?Q?+YMpzZ/mbz3ldGW+jmiR6WG4nuJzI/SKK3uNqGHDCTEoQD2TCkqLw4JuJX8G?=
 =?us-ascii?Q?u1J3s+gZJysmewVW9Wf5R9Gs1TE01r2m+P4HdguGW0M8ZFXNFpSU80FNozG5?=
 =?us-ascii?Q?JTHNaRe9nlLurODqWg/eIvR01JdP68B3hF6F9HLmNuyKEdDJbLpypK6gUT38?=
 =?us-ascii?Q?xTfXS8EtgFgFekhqVm9dwbRI7KzAQ5Mo/K5OeZI4VEqNrDZlhDjXJ8v48zwY?=
 =?us-ascii?Q?RFq80U4QcVRja5zFZ8mimTTPNkQ6QlntN7mNehsKbnRQwXYzOuMbzG0aOX3z?=
 =?us-ascii?Q?YtU4dz+K0UNOD+VUEmGzSjS2XqnDaHA8pY+hOIIKiFHED4JHaAYlalAOiqrV?=
 =?us-ascii?Q?0WBIMWV7C9JOk68ZiNe7jC7Fb1ohJOxHbbT7DrYZYujFW85BOlAmVcsMq9RB?=
 =?us-ascii?Q?HS0NwOG5oiaDxMWICK54qpJ/pRbRrlemAlWTkNaXy1jcvtugCpiPUTqWetbX?=
 =?us-ascii?Q?mxrUIN8o96pOxP6TFO7LTrlXEPgl3rlyqitiWQeyR8BxBF6DfAGD7V4fvB5a?=
 =?us-ascii?Q?/Nai0oU3+oHhMDij6LJesUC5kxZa/gRqGE05W7rUG2COK4tNfFkP1Vpb2QKj?=
 =?us-ascii?Q?4RIwHF4KSi2nVSaBUeKQmi/FLkGo4RFF7Hk+l9NXg01IdH6n6FS3/4n2x3Do?=
 =?us-ascii?Q?mx2q7X81G52RxeHbsdbOuW0ZOb7H8oMObNUPgJ7XL09uVDBckzXJp4zJxnLE?=
 =?us-ascii?Q?7RXRxdDyHQC7b1LFuZx+2s/EYDVEWZQXAHZXoQkkByLLOkcdZpmX73E9q9+E?=
 =?us-ascii?Q?E9aY6de0VijeuBGiCEfKqWBWquGmdf4hIQH5TRE5M/xF5pD/Ql9NNhVRi0Dd?=
 =?us-ascii?Q?lXXlxYejixI5vWQAd+v9R+oS4XorGR6OyZfNAiwILVQZB43UNLb5HP5ZOK7e?=
 =?us-ascii?Q?N8Sz95o9S5Ww0YMaM58fFyLunUHwxRYnaaqiRwCLdERN6ZV7RaX6YBDaNgUi?=
 =?us-ascii?Q?dm8oAaLkrXib3drMSr/TfqlK4QgbY0keq+Vj96BRhfaztPymgR9oh04hbxx2?=
 =?us-ascii?Q?R/IB00l0uogt9uZc9koqYdi3c6dzLPcoUPAa0gTmXz5ACU72/2EWBzVGYkhJ?=
 =?us-ascii?Q?hJKmxkwv3gwXKRD0Ps7MFImNyQzMUrFzXNAb2wNx0JRq4N43876gw1Qt2xiZ?=
 =?us-ascii?Q?VakijWgnKN9sw3Ndy09YKPjWQryb7+YqgTFUaG9TaQVCvv6ccoGNBi8CeqHC?=
 =?us-ascii?Q?6QUNr10Av/JUOCFCeVqPtDfAyGbCYsQT+9ETdk5cTq43AJZMcUuHIwUxKvB2?=
 =?us-ascii?Q?TKtIBzh2ZQ3zXbBOF9gSrDJQ4NITYN1Ey+i7FIkl6VnCkpMRDaNqpS2r1WF6?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0001ada-1ec2-4a3f-24f9-08da91d1977f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:37:40.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMIcY6ojYC3S2Vtqh749yXtTgdAQNE0WlzGWDUyy0FdCs11ptzyaqtzXTE+4j8PlJE37NWjTTParNS2TXSbjfJNlrBfbkygELvcQjAT0T30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080069
X-Proofpoint-ORIG-GUID: cqU_I9yWzpnV2N0c839wxMHS9YPxYRlK
X-Proofpoint-GUID: cqU_I9yWzpnV2N0c839wxMHS9YPxYRlK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows struct folio to store hugetlb metadata that is contained in the
private field of the first tail page. On 32-bit, _private_1 aligns with
page[1].private.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/mm_types.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8a9ee9d24973..7a33171a05b6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -143,6 +143,7 @@ struct page {
 			atomic_t compound_pincount;
 #ifdef CONFIG_64BIT
 			unsigned int compound_nr; /* 1 << compound_order */
+			unsigned long _private_1;
 #endif
 		};
 		struct {	/* Second tail page of compound page */
@@ -251,6 +252,7 @@ struct page {
  * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
+ * @_private_1: Do not use directly, call folio_get_private_1().
  *
  * A folio is a physically, virtually and logically contiguous set
  * of bytes.  It is a power-of-two in size, and it is aligned to that
@@ -298,6 +300,7 @@ struct folio {
 #ifdef CONFIG_64BIT
 	unsigned int _folio_nr_pages;
 #endif
+	unsigned long _private_1;
 };
 
 #define FOLIO_MATCH(pg, fl)						\
@@ -325,6 +328,7 @@ FOLIO_MATCH(compound_mapcount, _total_mapcount);
 FOLIO_MATCH(compound_pincount, _pincount);
 #ifdef CONFIG_64BIT
 FOLIO_MATCH(compound_nr, _folio_nr_pages);
+FOLIO_MATCH(_private_1, _private_1);
 #endif
 #undef FOLIO_MATCH
 
@@ -370,6 +374,16 @@ static inline void *folio_get_private(struct folio *folio)
 	return folio->private;
 }
 
+static inline void folio_set_private_1(struct folio *folio, unsigned long private)
+{
+	folio->_private_1 = private;
+}
+
+static inline unsigned long folio_get_private_1(struct folio *folio)
+{
+	return folio->_private_1;
+}
+
 struct page_frag_cache {
 	void * va;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-- 
2.31.1

