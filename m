Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D804C58DF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 02:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiB0BMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 20:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiB0BMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 20:12:45 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED8922949F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 17:12:09 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21QNY91H001029;
        Sun, 27 Feb 2022 01:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=o7wxP3KeCBhuH2gx+16y1DFvL9csmjQDctGzOO/eldM=;
 b=HldByX9yphZ0wHEonVHxO/z855IDIJkKhjWfd58E8w8jTcwb2Xq9x5rKUpgbAlsAoSWj
 AadZopPLGtu8yLHKSLFPBUjzm6X8g9FRY/hJa/KZwLAhzBvqbNq4DanPErt9BwHW87UO
 vzmPh4Vn1Qohd4qYQ6GNJ0acEM3sG5jHdRIoEJP+G0n6Nv/fuTrN2rzq45A1lepkaTv4
 Db0ku7jkElG/NN1h4C4gkr/jFQVqRAlbY5VSHrUdBZmCrHzwHGHtqDK9EN6OkcSKnK+R
 8RQ1aJwkZwBgXbYzH9SMLIE3dbJ/J4szOB84jfOQIyA4lBUz96QXGisxbOVQTNULNgou 8Q== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3efx07h0ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Feb 2022 01:12:01 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21R13O96009877;
        Sun, 27 Feb 2022 01:11:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3efbu8kc6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Feb 2022 01:11:59 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21R1BrFE57540878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Feb 2022 01:11:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA55AAE04D;
        Sun, 27 Feb 2022 01:11:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5436EAE051;
        Sun, 27 Feb 2022 01:11:53 +0000 (GMT)
Received: from localhost (unknown [9.171.89.193])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 27 Feb 2022 01:11:53 +0000 (GMT)
Date:   Sun, 27 Feb 2022 02:11:52 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v6 08/71] Maple Tree: Add new data structure
Message-ID: <your-ad-here.call-01645924312-ext-0398@work.hours>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-8-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220215144241.3812052-8-Liam.Howlett@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9z4cItH9ezmpwr7UmDLf5huoSCXlvni5
X-Proofpoint-ORIG-GUID: 9z4cItH9ezmpwr7UmDLf5huoSCXlvni5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-26_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202270006
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

there is an endianness issue with maple_metadata. This is broken on
all big endian architectures. Tests are crashing. See potential fixup
below. Feel free to apply it or fix the issue in your own way. This does
not resolve all the issues with the patch series though.

With current definition of struct maple_range_64 on big endian systems
metadata end and gap fields are aligned with the most significant bytes
of slot[15], rather than least significant.

(gdb) ptype /o struct maple_range_64
/* offset    |  size */  type = struct maple_range_64 {
/*    0      |     8 */    struct maple_pnode *parent;
/*    8      |   120 */    unsigned long pivot[15];
/*  128      |   128 */    union {
/*               128 */        void *slot[16];
/*               128 */        struct {
/*  128      |   120 */            void *pad[15];
/*  248      |     2 */            struct maple_metadata {
/*  248      |     1 */                unsigned char end;
/*  249      |     1 */                unsigned char gap;

                                       /* total size (bytes):    2 */
                                   } meta;
/* XXX  6-byte padding  */

                                   /* total size (bytes):  128 */
                               };

                               /* total size (bytes):  128 */
                           };

                           /* total size (bytes):  256 */
                         }

Assuming we don't want to end up with smth like this in a code which
otherwise relies on shifts and endianness independent.

 #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)

 struct maple_metadata {
        unsigned char end;
        unsigned char gap;
 };

 #else

 struct maple_metadata {
        unsigned char unused[6];
        unsigned char gap;
        unsigned char end;
 };

 #endif

rewrite node matadata access in endianness independent shifts based
approach as well.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 include/linux/maple_tree.h | 33 ++++++++++++++--------------
 lib/maple_tree.c           | 45 +++++++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e808794e06a5..e0c9f356ba4e 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -76,21 +76,6 @@ typedef struct maple_enode *maple_enode; /* encoded node */
 typedef struct maple_pnode *maple_pnode; /* parent node */
 
 
-/*
- * The node->meta is currently only supported in allocation range 64 (arange_64)
- * node type.  As a result of tracking gaps, there is a small area that is not
- * used for data storage in this node type.  This area is reused to store
- * metadata related to the node itself including the data end and the largest
- * gap location.  This metadata is used to optimize the gap updating code and in
- * reverse searching for gaps or any other code that needs to find the end of
- * the data.
- */
-struct maple_metadata {
-	unsigned char end;
-	unsigned char gap;
-
-};
-
 /*
  * Leaf nodes do not store pointers to nodes, they store user data.  Users may
  * store almost any bit pattern.  As noted above, the optimisation of storing an
@@ -110,8 +95,22 @@ struct maple_metadata {
  * subtree with an entry attached to the value whereas keys are unique to a
  * specific position of a B-tree.  Pivot values are inclusive of the slot with
  * the same index.
+ *
+ * The node->meta is currently only supported in allocation range 64 (arange_64)
+ * node type.  As a result of tracking gaps, there is a small area that is not
+ * used for data storage in this node type.  This area is reused to store
+ * metadata related to the node itself including the data end and the largest
+ * gap location.  This metadata is used to optimize the gap updating code and in
+ * reverse searching for gaps or any other code that needs to find the end of
+ * the data.
  */
 
+#define MN_META_MASK		0xFFFF
+#define MN_META_GAP_MASK	0xFF00
+#define MN_META_END_MASK	0x00FF
+#define MN_META_GAP_SHIFT	8
+#define MN_META_END_SHIFT	0
+
 struct maple_range_64 {
 	struct maple_pnode *parent;
 	unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
@@ -119,7 +118,7 @@ struct maple_range_64 {
 		void __rcu *slot[MAPLE_RANGE64_SLOTS];
 		struct {
 			void __rcu *pad[MAPLE_RANGE64_SLOTS - 1];
-			struct maple_metadata meta;
+			unsigned long meta;
 		};
 	};
 };
@@ -138,7 +137,7 @@ struct maple_arange_64 {
 	unsigned long pivot[MAPLE_ARANGE64_SLOTS - 1];
 	void __rcu *slot[MAPLE_ARANGE64_SLOTS];
 	unsigned long gap[MAPLE_ARANGE64_SLOTS];
-	struct maple_metadata meta;
+	unsigned long meta;
 };
 
 struct maple_alloc {
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 7ebb34964c68..02be5a5314de 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -868,15 +868,22 @@ static inline void *mas_root_locked(struct ma_state *mas)
 	return mt_root_locked(mas->tree);
 }
 
-static inline struct maple_metadata *ma_meta(struct maple_node *mn,
-					     enum maple_type mt)
+static inline unsigned long ma_get_meta_raw(struct maple_node *mn,
+					    enum maple_type mt)
 {
-	switch (mt) {
-	case maple_arange_64:
-		return &mn->ma64.meta;
-	default:
-		return &mn->mr64.meta;
-	}
+	if (mt == maple_arange_64)
+		return mn->ma64.meta;
+	else
+		return mn->mr64.meta;
+}
+
+static inline void ma_set_meta_raw(struct maple_node *mn, enum maple_type mt,
+				   unsigned long meta)
+{
+	if (mt == maple_arange_64)
+		mn->ma64.meta = meta;
+	else
+		mn->mr64.meta = meta;
 }
 
 /*
@@ -889,10 +896,10 @@ static inline struct maple_metadata *ma_meta(struct maple_node *mn,
 static inline void ma_set_meta(struct maple_node *mn, enum maple_type mt,
 			       unsigned char offset, unsigned char end)
 {
-	struct maple_metadata *meta = ma_meta(mn, mt);
+	unsigned long mnm = ma_get_meta_raw(mn, mt) & ~MN_META_MASK;
 
-	meta->gap = offset;
-	meta->end = end;
+	mnm |= offset << MN_META_GAP_SHIFT | end << MN_META_END_SHIFT;
+	ma_set_meta_raw(mn, mt, mnm);
 }
 
 /*
@@ -903,9 +910,7 @@ static inline void ma_set_meta(struct maple_node *mn, enum maple_type mt,
 static inline unsigned char ma_meta_end(struct maple_node *mn,
 					enum maple_type mt)
 {
-	struct maple_metadata *meta = ma_meta(mn, mt);
-
-	return meta->end;
+	return (ma_get_meta_raw(mn, mt) & MN_META_END_MASK) >> MN_META_END_SHIFT;
 }
 
 /*
@@ -916,8 +921,7 @@ static inline unsigned char ma_meta_end(struct maple_node *mn,
 static inline unsigned char ma_meta_gap(struct maple_node *mn,
 					enum maple_type mt)
 {
-
-	return mn->ma64.meta.gap;
+	return (ma_get_meta_raw(mn, mt) & MN_META_GAP_MASK) >> MN_META_GAP_SHIFT;
 }
 
 /*
@@ -929,10 +933,9 @@ static inline unsigned char ma_meta_gap(struct maple_node *mn,
 static inline void ma_set_meta_gap(struct maple_node *mn, enum maple_type mt,
 				   unsigned char offset)
 {
+	unsigned long mnm = ma_get_meta_raw(mn, mt) & ~MN_META_GAP_MASK;
 
-	struct maple_metadata *meta = ma_meta(mn, mt);
-
-	meta->gap = offset;
+	ma_set_meta_raw(mn, mt, mnm | offset << MN_META_GAP_SHIFT);
 }
 
 /*
@@ -6590,7 +6593,9 @@ void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 	pr_cont(" contents: ");
 	for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++)
 		pr_cont("%lu ", node->gap[i]);
-	pr_cont("| %02X %02X| ", node->meta.end, node->meta.gap);
+	pr_cont("| %02lX %02lX| ",
+		(node->meta & MN_META_END_MASK) >> MN_META_END_SHIFT,
+		(node->meta & MN_META_GAP_MASK) >> MN_META_GAP_SHIFT);
 	for (i = 0; i < MAPLE_ARANGE64_SLOTS - 1; i++)
 		pr_cont(MA_PTR" %lu ", node->slot[i], node->pivot[i]);
 	pr_cont(MA_PTR"\n", node->slot[i]);
-- 
2.35.1

