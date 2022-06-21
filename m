Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF87553C02
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354536AbiFUUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354385AbiFUUsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B03E6A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ6sTi009744;
        Tue, 21 Jun 2022 20:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jErIu/rEsxezdn4DvxX1mqQzqiYNMs+ov7veR8ZBXcI=;
 b=lcfre3TEMWhC0pv1SAcaIjHIzdeA1dsHdmy2P24GrdkWu3ArGUuInKaXSfdZ8qulI2Cn
 oRAOmrygp0+SRCYe4UReZDVmGfQS2jMgXREvDUC1ZE/n0JtfRh0c7prOu6PYNDOTFjJk
 ZvROIKRaKRXk0eVHEHVPggz3/voI6t0k/sN3fuy+Pa4kybWLt9OxDWXw3vU8cmKOyjiE
 VfQDjxk5K/8735EEnWww4owvLh68DwLg8bCDK/Zb2hNa9A7Azgij90FLAu6CWwjcxZox
 4Y0k1HSIWExXRIznGBhC5Wvi8FPN9exatb8BJTEuZ8WRqWb/H0FmwWXAXVpHQYkxd2rt UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txpdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhr027847;
        Tue, 21 Jun 2022 20:47:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wspfd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMd4aoRGnenqzfD97BhFg8LuHY8ZxWr1Y2990qpasLWck5Pse4MviAaZ3+CsU1t8YAgQxmOZLDkbuj6kk59QO7ElX3t0OVs3XoZQ1WeRvHqPJACA2wsQkAk7VNCcaOs8GOr5ubQsX/KRZVejNTyHIdbhpAgSW799wSPyuuIs5bgcqPec4NreRa+xAKLW2kW1+qpw3+LBhqkUVfswsvERrFG4umaMHh6+qc/0TFlNrYnQCN9a41ACtZ5u/CyKTXwsqaEtTRlLvzPqnn3YXk8BEP3Cbou++pOm8HAcRoDENvpu+er7SZtmtAQRKletP4jhfh0rgcKzfmBaiN/QIxx6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jErIu/rEsxezdn4DvxX1mqQzqiYNMs+ov7veR8ZBXcI=;
 b=bC9gS42sCAZNeZXJRvPHj/LDZM5aYJs28MbmlS2aLpOA2p66y30/Vpz3m4QL9eTl8FY2dLfgegBNEbLjRyKm6tywPa+f7w5mIFV87GmePLG26ql3blev9c8IHJ1Lw3tHy8yGsnML/qXxB+BA+s7pdWHRFQwRbmp5cGjg7j5JskY6/+H3JMYyKeIG9MGEdX0Yi0b5lqsdIe93A9W0wnufTxgA6UEaPt3eHFKdhL0zG8YhVC0ZCp2Wb0UNvb1YFhUhcoJmWk73e2lhu3Sa+hDLal39tBUpGIyhIwJ4jgtT33LA5aiEtvQzjc15KylvZai778Vu4/hdBbKlzMynEzeZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jErIu/rEsxezdn4DvxX1mqQzqiYNMs+ov7veR8ZBXcI=;
 b=T+drQbdWY2c4zPq2Bmj58X+AiPzdslAAtrU2X5vtGUeELcblodY2d/yBA38yniGlQyo9OEE4AxDA1e9ElBb9vCSiXBONcllenS1Z9oe3JxA55U1w3gyHkbpSP9aMvYnduPnlDMz3TDdxPK++zI5cZ7vvqBzlQLZTv8BGsY+4dqo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 32/69] parisc: remove mmap linked list from cache handling
Thread-Topic: [PATCH v10 32/69] parisc: remove mmap linked list from cache
 handling
Thread-Index: AQHYhbAPTZ2C4ACG6kaSh1qMoVO7Lw==
Date:   Tue, 21 Jun 2022 20:47:03 +0000
Message-ID: <20220621204632.3370049-33-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e97c3fc1-cbb2-440d-908f-08da53c74ad3
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB40256AE1310F3FFCF34362BAFDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICyNvoP+gjA9C0iSouKwmcvdqPq3O8PlRHIMSK3KaMhP5a3UyHe09IIQrtqaDSWbau9DaksDJZpyElD7mLc7c13sn5txxV7vltcn6RP/3E7JGPs+tKAW+jpuEzoq3B7TT2SH3yV53R6paYZRzVtUf3IJuHI1tnx/WgkN7Wd52pAnlggDseE7ps4WSy9FPyET8WAuPJTl4JNjEPZ/kWKwdiyNajQe7/A/ssN73wC9RQDYy9lWWMKQgMI4E14XjEdgMu4jVEKO9kN1pjbtBAgdMu3lEoiwhHWao6/tdDFciyXAuDpnHr9CkY6ctIPRdGc5aUk5HOdI1PNpv4h46zW+DiGEszTvDzbeH/k6mH+r3hdczM2bjhmakkksSUzHJlrShtCYgb5xbTP5yV32orN3/K20iTcAmTYyW9p+M7sCHRrYCKuQiv94zE2xM9RFe8Snnc5H2y20xLP7RU4mqn9xyGBh6bYhpsvNMhEDQ7VvJkmRel1lP2fkqHIy/yY+Ll8rvJRdVJ4XNGa4KuHOEBaKXDNbQkMB/dQ5LaImQbIKxDJei5RqZvZKAPZnIZ1he6WwD9XlA5dKqS5dvVHg5eYDwMCgeGWFyZdq30KoS0KOnmJEPhYzgkgDaKbZroFBu2MQ+YGbJRDaEhI4ncefl85//A4J6C2w8RBMM7O0dkuvM1Hi/DtMBjbXrJPcGasmDOjYy8FtRzCe67lS61vlvJOvLvrBbD0mTWdXNGBVY4vcqcC8BMnwQzuLGOqCNpCWLXjdEOgbO84c2FoEwQZ12LdX1BDzaEx9N5qZ14r94A6GiuA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tUCxPua44lsoggIXFw+r34KAMUHyoH3BZsRvpxKq7m1EipK9QHR+p7EF/Z?=
 =?iso-8859-1?Q?n3kmLPxkJTjzbMsvzcolI/iUJdZ6ZjtkYIN6S2ALie397Mkwc0AJUhBkeG?=
 =?iso-8859-1?Q?r0G3aVuty6tfZ9atcF+RcahMNtaz1mD8SQaXtx+ifSK0t+SV26wadUIUpL?=
 =?iso-8859-1?Q?Bbm5h6hTO2QV88P3+2M01qLVpR4vE9WHF0X7/alBn1p4JMxE3Acifr1P5E?=
 =?iso-8859-1?Q?byNRqHDYt4UHs7qVfPqEeOPec6XAQ5eMqOkoF9ch5llC0V0RcFwSMYBVYE?=
 =?iso-8859-1?Q?elNM1McjZVVX4C5bSGaf3CtxS1ApvN8YDRvceLh+r2TeWsTXfcnPwxS6M0?=
 =?iso-8859-1?Q?TDqJRix0FdFLwD+ITlU5G4tAZnffiyuQcjSgs5IaIfwv0By+GEbsRNGp21?=
 =?iso-8859-1?Q?MhUA1rxzeF4pxXonTEay6k+KNcyfYHqwVv4Fmc8G7FUE9WtpfICQG9akqE?=
 =?iso-8859-1?Q?dewWLuzNNzUXGvHHRfvZkhAlXzbjyZ7H414XVf4/+rtmBlLcRbAowtTGNT?=
 =?iso-8859-1?Q?4ldnyxVnGdt7SuiqLvCxJPBb/Rqw57OcueGMoz1QRu9HNTXXwirfv3rE+n?=
 =?iso-8859-1?Q?k8OCTOkiQlKmXe6AOHFddm8oFIIH/tYrygdi0PTI4B7gcgI85i/2PWkrum?=
 =?iso-8859-1?Q?+ccmqcVUETNIDj4c4zM8Jr9u0LBAYUUFKn2qzV8Rvg1oGlkWOLUhVWK3Rt?=
 =?iso-8859-1?Q?aWQ1em2u/sg9aU1l+FBKUn85IaZ6OTzPoFt1Ztdwvx/uhpm1TcL2Gjus/k?=
 =?iso-8859-1?Q?JKc2jNydzhBvTlCF3Vv+ZcMjiDDMsgOUMW7znha7avV7D9E/SxYH50IHnL?=
 =?iso-8859-1?Q?o4ODHEZDUXNEzUIciAOHiS2mcJrEwiZsno6NwnxY3zZ62LvZ+mA0RM8vL4?=
 =?iso-8859-1?Q?jdDmRpQ7U3LG0mM80XpYYasOqWb3ht4MOqIa+yS+ddTLtTSr/anJ5rgG9/?=
 =?iso-8859-1?Q?oCBVAg9Zzd3Os168ctpMrOFMkqPs3K+dOvwrdPhOp0hPVqfwXX3ot1YijA?=
 =?iso-8859-1?Q?JsJKtOmUd+oAs+BgVGfO8IrqhzJv4H2cQaELzrPMgAAZwzLIVt+I0B9PAc?=
 =?iso-8859-1?Q?NyMUj4th0iIQuNNU2+dOgj3bEByggyo8nawnhThlbanl2Xkgo3I9nUMp3p?=
 =?iso-8859-1?Q?x5wPzpdwBjA1tt+jn1dhOHQ7KsqAkJELcwQ3W5SgtiMR86hLyHLhbOpmWW?=
 =?iso-8859-1?Q?79BTzzxbFZ/LYN58W0OH9vvSFRSZPCnYBmJ5wHARBdANFICuq/HWyaPX+x?=
 =?iso-8859-1?Q?N3z9JhS3Rg76H47wpJyICvJ+meFOVV2xk340PYl0Kt2DDbAxIaiCEb56q4?=
 =?iso-8859-1?Q?4JJXTl21BU7dCSKC/emSmenRoa/S4FZrkcqmf66omOo+ONs0shFXvR2Dgf?=
 =?iso-8859-1?Q?S+q8z6yo6PP1SMTUyIeUdGJUrE/a4JDBjlShQdRMQYoEbyk9DZjlGUS/cc?=
 =?iso-8859-1?Q?bQjf5Oav9EakzeS/y0Zb3l6ICHWyzek6TJBCYFf1yioA1EmOI8HUn8ZfUC?=
 =?iso-8859-1?Q?NcSIq0oLSn39RE7puwY7ABnS4ye0wW8IX3uOAJUUtW/mMBubbhokLk8pLt?=
 =?iso-8859-1?Q?iK0A2ca5tDQjBkY9Mt5YtbEFLd9PkAC6Ah6nqj4m9bvnCHohDFM+S/eToa?=
 =?iso-8859-1?Q?E0Vm9GaoTgrDVOiwvLd1PM/Qi+z4pVa1Pyht6+uvG3M5T/YggQPIQ9N0TP?=
 =?iso-8859-1?Q?Ioi/ZjZGHOBEstIu3fCnB8Cbp4jpV4eWPlsAArcgCfJaampqIaYxvUqBHy?=
 =?iso-8859-1?Q?B9VzMf8J6EvNxdylGlDCL3pAvJfr28zwTPIbHrPMdm6eB6Aobp4opI8RKa?=
 =?iso-8859-1?Q?RsbnrLUSHmyLido5jq6yoPb5qDqOiSU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97c3fc1-cbb2-440d-908f-08da53c74ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:03.0350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYSP0IzvytMC1TUn+MIXbKj6ZmcTJoSLh5FEgq2wGd05WWLUNmOUxJN20dcXd8HJcYnRbw4VxTDY/RlSmWehMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: oKJ4uQO-oMIKOWJqnUoZh2j8-jLgTMJO
X-Proofpoint-ORIG-GUID: oKJ4uQO-oMIKOWJqnUoZh2j8-jLgTMJO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-17-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/parisc/kernel/cache.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index c8a11fcecf4c..3c8679e3ef10 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -660,15 +660,20 @@ static inline unsigned long mm_total_size(struct mm_s=
truct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma && usize < parisc_cache_flush_threshold; vma =
=3D vma->vm_next)
+	for_each_vma(vmi, vma) {
+		if (usize >=3D parisc_cache_flush_threshold)
+			break;
 		usize +=3D vma->vm_end - vma->vm_start;
+	}
 	return usize;
 }
=20
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Flushing the whole cache on each cpu takes forever on
@@ -688,7 +693,7 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
=20
 	/* Flush mm */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, vma->vm_start, vma->vm_end);
 }
=20
--=20
2.35.1
