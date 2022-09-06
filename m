Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6DB5AF1FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiIFRK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbiIFRIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:08:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D783043
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:55:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286GO0sH016827;
        Tue, 6 Sep 2022 16:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CokDxDX3VAQUgE8fgEHG3bJTJ+RnPpCT78fhlFqKRFk=;
 b=SR0qwnu6bkcG1Ir+/EaDZlbtVyNwvv4OdNZ597azFJZzQRVgcEU0o84VQkR08u2C2X0g
 FAVAwTGLi5gvEIyCRTV438dhUxRqzIdCMsSjLiIhley6jD3rTvL0qiLHQQgoKa5/o9bp
 pjIBR46EVJZ2i2DMMoKak3U8US+cZcpA0g9c/uWoFGx9iydz/ZuREtSLpEP2foMLZ/RL
 +otNGUS2qY0RqrAbh1nG/TVcbhA5zgIHuw9yxCLajEAbqrl5b0NlQQSU0YXu5IfkGULZ
 jnxU294nr9tlyqFczCZ25X9isosTYvqsXMu3PCWJ0UumvDR2Ju8wN+u4fO6bIqCASJte +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhspg8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286FASQW030608;
        Tue, 6 Sep 2022 16:55:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc35tys-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2QpmuHFkxVDkcqdddJgfSMpeVkyJKAK3I34l9ueZCoor5m5jRJCbiNaFVCZEY5Bl+m+NphhpDTUzXScv/GGhb0uSPQMGyGcyVlrJlF0PhutSGzgOrnBIPe0IvNQa76iBBuBePthMu85PqxTNvPaS+YqeLBnJI34sMKgT95qasFaw2XkfdY39Mcou4LtVS94ZzbokjRRar1/p5cFbgBc3QGgwGIyqlOw3EeXwYdSz8DxYmElTIwVxzOlfWaXztKF1lHhEo6U/QeMZ4vAXaBGZQUVIwQXmaXCsexBZcGDJpvdCkOjhlw42W8/oodeOxadatlhS63wYdTD4uhohXLUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CokDxDX3VAQUgE8fgEHG3bJTJ+RnPpCT78fhlFqKRFk=;
 b=mcMFxFjPftNNPlMhq/3VdTKD5Xz0iav4oxWxBOAX7yy73a4exNEEOnkD9DMXqV2WevgSjTvkVzV/9KM8bJZjqPH32T9MoafJ4z7SHhwjArE8KVj5VQDlsTrSTS58awZkP9SJQxWoSf0gVh5xUBmpkALIdFSlPDGWnMMmB1J+K4Tqsve6yvmj7mrJifH621YoinEi5MpHSzrnRisyQIhNPiBGtdMeSPma1o3S4mbBm9a/Il1+fJY1qXOVwEUpabXhTRK2UbFd/FWpRaLaUU8Eqk5ima5Sq4zt5uRWXiqEq5q8d/y24N+Aax5yvTCxdErY4MMraDBRbH8MXf7MeHuDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CokDxDX3VAQUgE8fgEHG3bJTJ+RnPpCT78fhlFqKRFk=;
 b=rM1mDEqRnVFj08QyRuOf5jylWGESoyrxRPyT70/qQD2KBRZf88LZ0V7GSbpvyn8LGOfs62zfsrejxaS4UTbymwBdlqEdGh4Y887eBFV8u2/PUpFSpBh9vphy4mLZQI5e2Sks3RbXKQpfOO91a5QqHTLRQd/CsHLbwSxE5RZdCG8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 16:55:31 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 16:55:31 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 2/6] mm: add private field of first tail to struct page and struct folio
Date:   Tue,  6 Sep 2022 09:54:41 -0700
Message-Id: <20220906165445.146913-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
References: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:217::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab78115e-ea11-4319-4c01-08da90289af9
X-MS-TrafficTypeDiagnostic: BN0PR10MB5078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8pkXIECAWOLfKSktgDsLzIY75kxRqLkSaX3YgD3ezB7Ig3ueMQdDzEurIKFCbzQ3oJ85brb0d1HP2TVYFWwxvT08lqCF9BmWpO6bl+C+naDARhCFIEdniuXqjjkdgGplkEgltDWCW3bKAu5nwgbxrYDckg72A5oNz/RcpCDmi07Z/Ns5BOh6DfnHhzOjrH9qAHJCaLETgG7KZfBxw7DiIQVKbOecyOyjAURVX+qePZ7pukR61EmhFe9bBGHNcRj/YTHK6TQ5j795G+GvQpw+acJbogMNNAVRP8+YtfUXPz4m7bf2DeJ20UOAFYivkgF+c2oxzOgYJwHRtDS8v45WAkLF9REuwwuajkck61e8DJuY4rYsCfIGyhE7WxT0RVsiZewPOtpoXqGhBidYeQQWpxTxDGb5EPs+2uYXb4VdalNEmDcgk6pTM7yL89M3zUg5c9+pne0oqGz0xYs/sbrgU8u3guUm77iEnDpLEG1pLmEQn61rmJlflsUuKohr7jKsSpyY3K3qV15Zh33INQCwKCeeF2qqOdOLzIyWx9p1tB1Rp1BSfNO81y6BEV9B3vihQmEdkasipkCb9veOZLTerFQIfZcqNA0kfUsY3tuuusr4jRGekvz/PyudqFWDDGnRjsU92ood9blK+/9O4waXS90siIfudHbiHzmjcJ60Z4jGtWN3srt9OkspRMycm2Uipx8csitA4z2qZmpa9CGDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(186003)(1076003)(7416002)(8936002)(83380400001)(2616005)(44832011)(5660300002)(2906002)(26005)(41300700001)(6666004)(107886003)(6512007)(36756003)(6506007)(86362001)(6486002)(478600001)(38100700002)(4326008)(8676002)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8zornWPPgrLWStCjnRFVqvQhbKfVpZ+ozJdsOxqVMXpM9CcwirFOvRJWC0OV?=
 =?us-ascii?Q?tHQS4/F6I5ePJoVAoCNryxClZvOuIbjyX0P8MzOgJU6OgGAoIg1Ke1Kr+tN/?=
 =?us-ascii?Q?ZrbbEX49JbPp6dYwsuxBvetBPLGinHH4uw7niAGCwDW8FUIQTik/3zIqn8j8?=
 =?us-ascii?Q?1Ztp9VCbEBkK4t0U0175Y5G71JKQze6bjixELmoTh5TcuIkAbVVaZ+MHYZ1x?=
 =?us-ascii?Q?Qo4qIwxgzbL2lpXHJ5l7TSkznpfh6U77aIi11DDxnQnCAt8RgmjWF7eTR9LP?=
 =?us-ascii?Q?dZqDvOHdXX5q4VNppStYWqCQ/0yUYbvImaIqewoKvDvVARYe7nFGdcv0j1rE?=
 =?us-ascii?Q?Fqj3KxHBczW0PwGlQZXxznYs26WulOzZATg/JAFJfmRLNZvqiIH0ug09vSav?=
 =?us-ascii?Q?CUb7cM8nic4nolj0DzKitSYYKRH9jMJUK07J+Cn97NHtxW/rQZK0q9Gz82Fq?=
 =?us-ascii?Q?G8Qgj8ro5yDdZzoZKQueft5nAun9oreP5gq9bxK+nHUHeNDtevKE0eCoW36b?=
 =?us-ascii?Q?CZiIvqJfq4WDYk4yOPI6CPo0hqQSbvGPwdjclBBFK1sO2vYPUTTzPjlHGHq0?=
 =?us-ascii?Q?pdtzSIn3CoZvtl069tF9Y80Q7o3+cYY1z1Iz/iaCYTsy6gsbdG2yB72t2H6Z?=
 =?us-ascii?Q?hxgQlMzUaRPz1vD7IAsrmjRN2KEH4BBIvZhUwDmVSpP0os+wFkCWqGHSrDsF?=
 =?us-ascii?Q?X8w5erqOlx8f/m9zyoV4JSJVWQLfMwTRi3sPM0r+s+ayez2bAMy0LvFnbPn5?=
 =?us-ascii?Q?k83QTUhBdVvpeeyQzmB1EiTZ7LoJ60SPdTIOKe674TQ0Apmgg/yMMyPVomEf?=
 =?us-ascii?Q?7p48LXvm1zr8W8iHm8X+xggEQJUfcXyKjgiM0fQGbLDg9ejVchk/x6dyyhwn?=
 =?us-ascii?Q?xhBUwOoDwJzDrdKQdJJNrzY9PqpSWe7FGAVZs+6z2vO3JAlR2TzQA3TOf0nB?=
 =?us-ascii?Q?+8P0BgKD9s3OBw2Zxe5akq30VimSm1iPJ7za7FFyXfBOXZLvEpaafYOJYoA+?=
 =?us-ascii?Q?eR0Nkw0QSo8LzoNIgRncHEaQ0JgWCpaxptBX09df+uSBEtgIjJaNfRgY18uc?=
 =?us-ascii?Q?U1tp5Y9tDj+g7Djo/nG9Mt3l4o9VEQ38RzydeuqKoyzD4Rpo6hJXuiznv9Yb?=
 =?us-ascii?Q?vEPex6nko57gjf7NY6o2ytZED5ccO3UG/vTuEMtiGpaw2P3GKZpFVqqA6r49?=
 =?us-ascii?Q?UY4shgeHvi/2IvPpP+iB7XBCdD48+zKtIGnmifUggRf4jkZ1Fs9PxpugTS9E?=
 =?us-ascii?Q?KHgcNKV0b5u8saAV9eh2eWDETfUK5eBlEJp31WbHF/HE/rB/tGAlY7gUBI7v?=
 =?us-ascii?Q?rAD4tOYd2eO3aK7HtImcU8mLQCe/009ya1/K9+0XhNFkcdFfUIaEebMqbkGT?=
 =?us-ascii?Q?PRW6Ho0dfrstXP9SlEIWakr8IeT8+VNqX5MW9DhKYbCQRrL0g30pzXXKzyHb?=
 =?us-ascii?Q?McEUMlpR25i3QzT5vsb69ZjCB78AJwvLvYskcm5vYTQHAAvhQfFeac2IyZhF?=
 =?us-ascii?Q?LiNqZDm+RKA/wrRljoW9/g608OVO95Hp+mMaZpE8xIunjnQK5aOPyX9HZS0h?=
 =?us-ascii?Q?hxVYsUYnaTPYLcWFagrO7ZusUVgitOU82tXVvoJGGEgscNGwTvV1lmSYgPJd?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab78115e-ea11-4319-4c01-08da90289af9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 16:55:30.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/op8qtOT/Z1xgTJKX+rpw2NygHb62OIu+hFsvpU8IVunx7CylyMHN4/cOJtHwvFfgMq4K2W3ce9O3sx+vilID+URiUBLz0KotHBmKDe1H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060078
X-Proofpoint-GUID: 7jsV_ISRms0c6f2wcYiaXjFKOsrC9raQ
X-Proofpoint-ORIG-GUID: 7jsV_ISRms0c6f2wcYiaXjFKOsrC9raQ
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

