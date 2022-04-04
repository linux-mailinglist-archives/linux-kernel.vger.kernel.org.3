Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD8F4F1757
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiDDOmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378066AbiDDOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:40:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3DD3FD95
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DlFTS024455;
        Mon, 4 Apr 2022 14:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rmWRLY+NtARVEa6qnelKzwLSj7d7B8eYEBnxdWpzySw=;
 b=sjkMiPfMH4rBuH6ocxxN4dR1pAH8G9+T7ISPgiEqNXRCj1SlRusJrO+vDs4x/zkdhwDV
 AXLXCREEST9OddDQbdXmIY+5zeG72It5eg0tzBInuDqmvdPSBpM5n3FovplTM20cjc+j
 lhUWCKnAKX1QFRPSCCrzjcNrumIWW5bdDAfQSHf9tOeS+2bFKur2/EjU5N69+OfpRMcR
 Mh3Tn/UsKK+AtTaF0I6W5d1GJOrjHKP6Zly8C1YQHmJhbESYyEYpTbV/txnHsop3zxxp
 njDC1smZhLmgF4I+PcTmmsAJupnVijEpk4pMFMUVCVbXxfYEwaql9LbmThULfj8AOBsC 1g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaZ6034331;
        Mon, 4 Apr 2022 14:36:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mj48-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C17ybKV6aKOgwvpksW3+Amj/QNQACCFMkaPEs9GQnQmolFGBMVAT/yzghfCSp4zzPlpCVd0QGMQH0XNpQbh5F5mcNycSmClErUtA5ttTOi+n2Vj0nLqgmDNXACTjqdPnFgcrdz/vsj0rhrBgLf2uPw0kJKOJSZoqvgi6DbnmZBfNMPWGnC87ZUj6RNVTcaI8aI5yEyGYhR2C4mP3jg+Tb2wNo+XXcFOlqDY7tysCqK7xOtNdI+yMJYrJ9xvPRtsYySadG0Mp14Q77lvrcbjyyU7A6YW5xRxLW+xsG1v+inO7iCTa+mVvSJqYVztbc4EVoaGN/lTs3jf3nUOO89WjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmWRLY+NtARVEa6qnelKzwLSj7d7B8eYEBnxdWpzySw=;
 b=oMfCV1sTTwvqhWn/NFpT4SyuSa6viRkWWHdnW4Z/6/Ezxr1UFVTEWpLR2UFlwb4stV1ePaSj7VqIl+zJe/9qAFINFRayNxqwxiZ8q5UySRQAUhTHAMFgPKAclbWQ22aBVFDElDsqXKKEjDLLrpBWht2ok8sKj19GlfE1paX5n1Yn0GvVzyvDLDPqonSyJ0gM6M87TYtVDfyGmhOgHmT7B4AqV/Do+bORn9WfUNpa+wcj7qAaYBClUCxxAJEnkVEfq+L+f2jCKRHoS9LbZEeSQCfy9Co0rJVs9QWYMMkK00wEJxLcEJxGXlf1Ko9zeJ+QD0i4KN2USFP2k3OJ87BGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmWRLY+NtARVEa6qnelKzwLSj7d7B8eYEBnxdWpzySw=;
 b=FIj2v0C2QTzzwSk6V3gyE2cf/jwkIaOf99aA0lm64P/u/x4QMdRgFiJFU+M56y+5hly+w/rUGEb5944NeIiN6NwKrDmnyP2wgZjMzemkjDVU6d5L9gRT4IFyVnK2ZIb2V0hdQxTNqrBwr32fQzvAVpGDii+4m9QhFHjnGBxVzVU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 55/70] mm/madvise: Use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v7 55/70] mm/madvise: Use vma_find() instead of vma
 linked list
Thread-Index: AQHYSDFKRVO4MUaaX0eYKzJeXibXfQ==
Date:   Mon, 4 Apr 2022 14:35:54 +0000
Message-ID: <20220404143501.2016403-56-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5092fb60-4b1e-4cba-be0a-08da1648822e
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329C0D309E135C1EB5DB895FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8VUFpv4FIpLT1eE0OeI6uVdhZscex2bZVWcedImxX+UsshpAiLI6AkVlDMlgJ8nl4aO1UJBQlHvLUOD9elgek8k29ZNQlXzTqWAXCE0blXJtpZzoOxjx0FVMuIHge+9jQnXTI7YRMTeuDtdHBSJ+DBRJZJTuU7bJDvrgUjzPcT1GYEHs9Q+Cwfuo3XUuobaVVKMzxKZnAFMJH7o1F9nrgCsQYJY9uFUtpOws46O+3EIVUPFvpzOSgVdqzbWYFO+AW4147AlADRc9sJ/qgWt1F/aoUjwkYQVj380wT2nVJbbpvK76yLF/VEcKh7kVJ7tHw8+BhPRGnumXqgBi+ZMkv4muujl/EfHLoT2+J2YnYs1vJM2cd8asKagFubjKe1D4iQael0L0PeuyJFYAZpXYS7dZyduO2bOXD5hFGMAkFQWe6nvzQKiBast0Dhy3Ozs2EIgH7dpK5A+N0cR7fO1MgWbZKL/UvcGBDGYjR4O0z3LMxjVlMX1sVwk6gnYFYW50Nuffsp5UrVRTkbjsVN9Z1PgS5bg0wtButE7lSjSnmFHIWTw2X7vCtVAy7zT3so96R6K5WXoH4QBAJ7wJghFFaC69wOd3AkjnPZ+W5bh+pZPyMOmDc25BR9QAv4QICqv+tXCqvqA0SQuU/UcURGgdTlouKtaE+WXSMI8L5cwRK3pXZ4NcukAdqrWJQFdbMNPfgsQzEflfFdTFIADhatYbtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(4744005)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q8VCGAWxUWf3Hr3ZfREE7u3rQno5X/hGe8lITGWghTLWoobpncWOr30r1F?=
 =?iso-8859-1?Q?xgDa0OZjpSbedP/hg80n0ikjwMbZcP/XG+L31Xw0M/oEd7b8FfGA3NQjD7?=
 =?iso-8859-1?Q?XGq4sLmlhImQH7OyMQtFwAI1ueJP3ylz1/x87wVymthO1gHIFHJoZPk7sv?=
 =?iso-8859-1?Q?NlkAB+snuR6J/mMwo/7EQMxqRkIF3a+vFq4evLWRFEe0Tesa/fmYOTp8tm?=
 =?iso-8859-1?Q?uMkrm/74Na6TLRPGfEyKMiAgDSEP1FTx/Idm2bHAoeY4rOJCZ854YIdGYE?=
 =?iso-8859-1?Q?F3DOwe4tu/bp8PWQOMhRBeC3oc2U7US+o0NGMxL19WEdSKh+Pg0K2AaNR7?=
 =?iso-8859-1?Q?SvqU8Q+8KlW/gy/XpezY4unL+kNxQVPBltzOrbN1sSHSE1EcLO7xb3UysR?=
 =?iso-8859-1?Q?4SwvDfqMPH1tK4W3aUxFsjYTgtm36TxG5JNQrgLyKUMEzCZhOlFz4C+RRn?=
 =?iso-8859-1?Q?U5rMTWXwDMoL1PzfghE/oMWxboKjIS2y3iYqazBN9biGZYSUDxjCHluN7s?=
 =?iso-8859-1?Q?3g4AyRRjCwObKG9UNpQItkRqfR9dvMkyZXEaKgUUdVbaJOJsTJgmE+WwMW?=
 =?iso-8859-1?Q?jYoetmhtM2L57DrYOTUBW8LZZJasLNt5a8UzrWnLNpdLwngHqlB1a4KAd1?=
 =?iso-8859-1?Q?BgGgBX+UpCOnA7sjsH17okFHvHy0Oh0NulMXWMBqB9SfJDH9fqy37R95Uf?=
 =?iso-8859-1?Q?ywmcdoHsOvfXjRUCCkeunw339iIoq8NZagILCXSfqOhBrmNCimh7BX8X5+?=
 =?iso-8859-1?Q?ubeA5UHug10FUNWXhpXpxH/zSeGTa9mDC9AY/DLifVu7be8G24m7Us+n7x?=
 =?iso-8859-1?Q?KgWeIRVRkxaP9O1NCiZjXuk1XHYgXehNkGV7BP2c+Tf8Y8rD5xu4zIe/JH?=
 =?iso-8859-1?Q?KevbMaPKAgLk/KIxAYnSUJGvoAZ1DMK1+TcbGnGEz+5oNgNl/cA8hbCLST?=
 =?iso-8859-1?Q?hXby8ybfsSJUTKQoV3NppqAOn0h75nPvryLbSYdnIjBLrdFRQJk+BfOIkm?=
 =?iso-8859-1?Q?h2QouH5Kg/jV4rBVSG3ceCOwNQpLTLWDZIa2FiXBJNn8jQNsEnUHh2BfRG?=
 =?iso-8859-1?Q?Qd9KKK4Psgxk1dauFq1A0UO9awhZI9l37V2cZ5FdZfwNAuFi6I8SyCxq9R?=
 =?iso-8859-1?Q?uwcVwcOab+k4IUJGnjcitjgc4Bn5GC8OO9+irABa1I62Axd7gU42UYuXhY?=
 =?iso-8859-1?Q?NW7FLzWhcpo9zmwfmu7lo0v6bBJwr6uLz8CBscKYsYeZOOw9XsqJFtLfSk?=
 =?iso-8859-1?Q?o+ALOH6wxSG8dxRSZyQqKwonmalYPgJb994IeM6G+t9XH7JOleGIRF8kJD?=
 =?iso-8859-1?Q?jWOnzeSCG/MrJU90TI9lXZHwBd3VR/G0wpuyR2GhcscskRjXl7PZ5I8uUz?=
 =?iso-8859-1?Q?zjc/+9TMoqgtMPY886Xl5ubSXt0+b0ncDKsZsKswzdKGS/x5AmN7d6HByS?=
 =?iso-8859-1?Q?rNfEy9JpFrmUsJwbk9TqZ0URbQxbjDtmNy5Jf4CETIFFsEifgyQsYapTPT?=
 =?iso-8859-1?Q?nh3cOX7TM5X2hlQK3c+8g9LbUD4TLhxckaqVtWYR1+M5OxYEmgu4HQ3v2Q?=
 =?iso-8859-1?Q?EPoSxIl7qM3o/cTHU5LVp1dsst2rHKlAIISoK3vp3ZCUEgtrr8jY35dY7f?=
 =?iso-8859-1?Q?Cx95pK5izRVHTzpoYyM0LjNe6eTxaSD469xuyKX+MNKecHDZLkoqd8fRbN?=
 =?iso-8859-1?Q?K3bamx3DcyVSF9Cb/fc50C6coPA/1QsRkuorqSStH3jT2PU27/m/EAW2BB?=
 =?iso-8859-1?Q?d4zXCPl4xme0+HPmqGZgpru4Uv283YUz6PjcDNubyE7DjJB1638Y0rmx2z?=
 =?iso-8859-1?Q?SzvPv3I0DNx88AtEoIh/7ayptyND3mQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5092fb60-4b1e-4cba-be0a-08da1648822e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:54.2366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ygd9scFGaY4piFWnRIziKaoPvzjo4vdgUF5F+KVwl7ltwpGwpcWw75flYrg5nHzJAOmEzLDUoEO4f/Jee8e+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: ucljDROkJCcXyHUvEYzVB1j6zmvgZzl2
X-Proofpoint-GUID: ucljDROkJCcXyHUvEYzVB1j6zmvgZzl2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

madvise_walk_vmas() no longer uses linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 1873616a37d2..7d5d5d7f0005 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1227,7 +1227,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned =
long start,
 		if (start >=3D end)
 			break;
 		if (prev)
-			vma =3D prev->vm_next;
+			vma =3D find_vma(mm, prev->vm_end);
 		else	/* madvise_remove dropped mmap_lock */
 			vma =3D find_vma(mm, start);
 	}
--=20
2.34.1
