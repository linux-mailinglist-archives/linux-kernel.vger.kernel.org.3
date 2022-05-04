Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D2B51935F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245334AbiEDBU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbiEDBS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:18:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C143AFA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KctF4024988;
        Wed, 4 May 2022 01:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rtEgJ6g/+NrMFge7rfz5iJSFQ9yYY7v2UpbI0NJG4ec=;
 b=uk3s/AncAFsFZ101mH5kz2+rB9OJ9EbgpQjowFzBA6wRpN9+Dunjgn23tYzbUK/pQ7Gv
 t27nuqN0bbG6LQql0GLjQHcKL38cWWbqeAwIUdDjyhmZSmuITuEn6UZd+wwyapD/UZXS
 WE04TCsVOf5+WAOUpuhcLVemxrrpah+qGt+a7azi36+tAwshLSbA2xt+kT0tQ8LXCqbt
 09n8ax/SOej4J8BT0WydTqlqW6q730jXQ/5AJplxbAdbqq0OSyc8cAdAYHIqETTeJSS0
 Hl+zbU7FgoIpj9WejAq6o87KEfPtu2ciQONhl70iaz9/Pa0JGRHGVyF5lEqAx0RuE43N Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f6c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXR1013207;
        Wed, 4 May 2022 01:14:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2aVQtegsGWqSBXMESLSY8gRJmKJTSNJEzr/8VXeBmJFHxp7WmKkWO6KrWFKrwQsXMxG0hwuiZLoClJX9MuIUNX0VUqaeFte1F2bQAc7SU4OXEkKxDa9geYl2VbcAUGpffCJbFWHh3h86fypdEyTGcYqS/jj8Rn/r1oXrU1uuQSqu1ygtixZ+Pl60rX+KO+dE7cc8oLRW3GNyj/ZOVfoHiiC/u+fRts/lynV3ZxGiZjX7Mb4Ok52iKqeb6BrOMn1fd0oxWVJ1hZUlamyI+C5y7b/cCh8ukiJbMn1fvIu/ywmjJALiz5B2rKZAZfbPxz/880QVKb7Esmb9RDV1VdyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtEgJ6g/+NrMFge7rfz5iJSFQ9yYY7v2UpbI0NJG4ec=;
 b=mzV7RJIe+nCuqmAG1jje6SeSV0ixP+wakmLMVsmMh+NkbyqiKtcGLO92CQaD4Ogu3QJjYktbjx535mtbFzeuUvSm2mgkIvBoJQH/jVVC2NpdJx3DLqhtdYNltr3jWA12AXcO4FmBM5p1RciuZsE3cjEaWilnJZKfmV9VH2H4gO/tWEcsbkiaajtQOwHh85TR7Ft8tOoeSdfjXNlMBQSViFL3yyOEw7Ay0ED74/w4yFDd+T3bIdI3eLWzytax3V+17TnmZhCjUsHDoYg2+4QBeWhHgfZJK/X4J1AhISMKjZ9PVT0Q1AQuRMJxvydFHsAowyPj2E0LczXhCNTL8c2QmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtEgJ6g/+NrMFge7rfz5iJSFQ9yYY7v2UpbI0NJG4ec=;
 b=v2R65lp2We/Qkr4O5HYFdAztf4b9g6sI6KDtZGTwxrHs8dU5+j4QLLIcLfSdb9XpsLooDH8UF/fsenJCWNlMPoUraVIBxjuEqUnU3Nm3v4aaWSsTxEK+/h9YuJ1WUSI0SVDFs7EFPvyMJTZ+vIK5IVXWC29w4aSYLF13fCd6Uzw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 56/69] mm/mempolicy: use vma iterator & maple state instead
 of vma linked list
Thread-Topic: [PATCH v9 56/69] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Index: AQHYX1Q+3skD0a2xEUKL+wRRlZUrrw==
Date:   Wed, 4 May 2022 01:14:03 +0000
Message-ID: <20220504011345.662299-41-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38142693-32ae-467a-6bd0-08da2d6b75e0
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2688092D456B5B0CFA158F83FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cdGCs9gFe/Iz0ODEhIWymObt7Mn2V1DwMUpSj5u5uZxZcMRFupbq1v9l9mxlR0EWw8I0JxzoxeO/sztmeMJL9ztSn/8Zs0FmI0b6WxiqifQHNMn92Gc3LZouMxewgamBl390VUjECQNb91mi/vMf7nDCyr3cwkZHqFUIn/Rv2W5Y/mS+iKlEPzi0VtTUwJjlRP+f41IynEIFBYhzqqhyKCSJA+SHNK7gnYldxPvMMFRjYJm8oyoFsgNGQ+0+SqO+4y5ZrWDtIddJZ/MgaCbNSjECeVRZz3rgoihYiKQlGDsAuRMPuNbmYmUcg3dc6lkVPdak3nplcZdl+st7WrBy54ocZcMB4RSJX9CleEEaJABSuVlJsjhez3+stJwcFKe+lewwkX0AemkyMMHi2GoCVqZEKDzcu7qQBo71xYmWxsZdjreJ+Z2jjTLY0QaD7M632cdwSjmDXhwTr7A1wythB9e+koAOTEcD4x8Pm9W1GCNC9GKXNaqd+XDxIrATZuKOItQADVkAwHMB2ME9OPAhXCmywqhjSheldewRZkdnRu7MuCoQ55EJz9dzvJI5fkOGAqs1QAdJccr3Sz+AcWdzia+E+x0OA6PW5qPfXo1LZmYJqrfOe2LJc83YhfQ8U41lcYyDpyfcapaZRKnSw0hRrBmtTexucgiKbOd2NNDRNVDPTUAAuPbGMVvi9CF+4m2RssBlc4SU+6R679AH4WO7Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mDQ+2VW0Lf03DlPWL3GJsmdSYByUZlFVgw4EvtCGZnPDdcAf6r4mTGRYin?=
 =?iso-8859-1?Q?R2vHmK09EGtqrIVMmQ8p/Nli+ddzxt8DiPvPHXld9ElMwLK8QAj/zebITY?=
 =?iso-8859-1?Q?b/AS92CLim4Awr62chu5xXwpIZx6gd9M7ec3fDLn0vrYwAW6V/gkM4XEZV?=
 =?iso-8859-1?Q?bZ9E9Q8eLKJJuYa2sZyTFrDt9uJIu3z9H0l340hGa/TpyP/T33Qn4WAqxq?=
 =?iso-8859-1?Q?4aRCUccghV2xz27mh7mT4w99g9iffo8doLsXYUZ2VkqSIsk911rzJM2TCF?=
 =?iso-8859-1?Q?ed+LtmRXnbnyxwtgDi1lnztBGYxxrmQtGwcjigqi3ibDTBUQGv06fgby56?=
 =?iso-8859-1?Q?5O59ExZYJbcEbBEGXHj1O6bzF4hvmM1C5NemASy16xIqSzMXUUeo2DHlFI?=
 =?iso-8859-1?Q?92EstFuctVaVxS7gjXvz34yQJ/4YZzD97CcfmABeCg7J0dSHSReX8box/Z?=
 =?iso-8859-1?Q?BhDSMrRuVb9Eqaa+mRhGhKQKj/r0zEupv0Y9/8Knds4wHZ/ouEd5AbO2g3?=
 =?iso-8859-1?Q?JhdQz1sDSbBgr+noF5lopisYdc1ufFyC+zgcs8n+CsGsLVDFNsBupBgm/h?=
 =?iso-8859-1?Q?1VyXkFfdY2yY5rJS/yrwSlqadAuRk21yP6YQ6pJL7MnpE+2ABDnbg9gPtU?=
 =?iso-8859-1?Q?eucoG3u2kEKZird1aNchjegFFoc5wkXZT9KJoKnSRJ9Otljk8exx7iJNRf?=
 =?iso-8859-1?Q?qxstldM1UeOCTCYhNB3FRj2Bs6YPBmm7nGd1GSnaI9unhXXPqtUjG5xGX4?=
 =?iso-8859-1?Q?h2Z5L9PMuA9nptFN2hypZNeHxQrLFGgIPkOxiVnS5Vmh8qe4gfehP/cv77?=
 =?iso-8859-1?Q?VwcddKSjRz1ieZHGW83HsaxIGipoB2jvzqx+9V5DTQaM3ZAAv9mdFl+99Y?=
 =?iso-8859-1?Q?wH484eAyLj4QFuYRsEGbi3ZIyF2TdVJmwQjbN1yHGlDIllLzVCRA9WSMRL?=
 =?iso-8859-1?Q?915bvjvaPEa7tpVU1AtNBOIwA/dP2i3vfLkOpbJAcYNcQJq2UP1RsuBz8a?=
 =?iso-8859-1?Q?ANFk4iFhJgsPJcOI/IzZaxU5LAtSwJe9J6yXV56ZJ6+XumhCBWhUs1Shs8?=
 =?iso-8859-1?Q?2TTto0HIIhU6CxjIiDIsadg2wquXLMdk6kAfLIwtyR84vddfuXpD2Er4NW?=
 =?iso-8859-1?Q?wBtyqckuTz6c2mtnbIvuZIUE2SMUNgh/66VYfRkZvwAWe0M6gIis/3Zbup?=
 =?iso-8859-1?Q?a4GaTzskKywoSEnm45YSux26BGXiaRmy3+NTpkkq4sqygE0hE3m8Qj04Sx?=
 =?iso-8859-1?Q?6N+gQZapvoFNa6AsAZLTpOMR/5wrgRUAoAaXJ6TspY1KK/K3ZAE6TTeTZv?=
 =?iso-8859-1?Q?t7ozRmZAvSJnRtpSZoNldyEOawIaXgj0qLhI6wcff6n0FX3+ooVSdLIiQP?=
 =?iso-8859-1?Q?lYI685UzeBLihc1RwQvRX+K8utOCYEgXucxvoiJww2oEMJdlNdAoHwPpdt?=
 =?iso-8859-1?Q?khoX2bF/dORZEht7gqlTs8hS0f8zdkmK4n8w9Dx0dVIi6DO8WLkYu2QWEf?=
 =?iso-8859-1?Q?WfAGZEscbZmpCENLAXhWvsfPkl5FAxE2F7+pPWJN2tUu0K9lGust9EW8aH?=
 =?iso-8859-1?Q?JiI/7DE58ds5A+0TmgIQk7Gpcc2pEMgSSwdHX6rIahzN3mL8wgMubxU7td?=
 =?iso-8859-1?Q?NYNGchjFpcAvTSls7lqqYrYQXEFTRaWo3xeTcstb15OMGgL50gZxXmjnRR?=
 =?iso-8859-1?Q?G0ed8349LFjP98nCgxcAzMjjnoiKTAvKLce/kbidOA5Ij2Cn7SN7PigKJX?=
 =?iso-8859-1?Q?wj2WZ7zaLYfQEcEih1nok8b9XFuLzBHgZnfD9oG7gBxGBca9kobEsRDkga?=
 =?iso-8859-1?Q?61XGi9nVNJHURnx1nZI2HmAbegZQPRc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38142693-32ae-467a-6bd0-08da2d6b75e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:03.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkdO8VACHl6HmSM682MgZgGI7yPkuNNscfkfFkQFrqOm35Hf889BnxsIAVoyfHC1TzML/5Tl839Mj+ufAGenxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: AYWXTTPaw17bSyjIlsM0ypeVdQfYeMP2
X-Proofpoint-ORIG-GUID: AYWXTTPaw17bSyjIlsM0ypeVdQfYeMP2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Reworked the way mbind_range() finds the first VMA to reuse the maple
state and limit the number of tree walks needed.

Note, this drops the VM_BUG_ON(!vma) call, which would catch a start
address higher than the last VMA.  The code was written in a way that
allowed no VMA updates to occur and still return success.  There should be
no functional change to this scenario with the new code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mempolicy.c | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0288ffaea064..df4487767259 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -380,9 +380,10 @@ void mpol_rebind_task(struct task_struct *tsk, const n=
odemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		mpol_rebind_policy(vma->vm_policy, new);
 	mmap_write_unlock(mm);
 }
@@ -649,7 +650,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -664,9 +665,10 @@ static int queue_pages_test_walk(unsigned long start, =
unsigned long end,
 			/* hole at head side of range */
 			return -EFAULT;
 	}
+	next =3D find_vma(vma->vm_mm, vma->vm_end);
 	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
 		((vma->vm_end < qp->end) &&
-		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
+		(!next || vma->vm_end < next->vm_start)))
 		/* hole at middle or tail of range */
 		return -EFAULT;
=20
@@ -780,26 +782,24 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
+	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
-	unsigned long vmstart;
-	unsigned long vmend;
-
-	vma =3D find_vma(mm, start);
-	VM_BUG_ON(!vma);
=20
-	prev =3D vma->vm_prev;
-	if (start > vma->vm_start)
-		prev =3D vma;
+	prev =3D mas_find_rev(&mas, 0);
+	if (prev && (start < prev->vm_end))
+		vma =3D prev;
+	else
+		vma =3D mas_next(&mas, end - 1);
=20
-	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D vma->vm_next) {
-		vmstart =3D max(start, vma->vm_start);
-		vmend   =3D min(end, vma->vm_end);
+	for (; vma; vma =3D mas_next(&mas, end - 1)) {
+		unsigned long vmstart =3D max(start, vma->vm_start);
+		unsigned long vmend =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -808,6 +808,8 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto replace;
 		}
@@ -815,19 +817,25 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end !=3D vmend) {
 			err =3D split_vma(vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
- replace:
+replace:
 		err =3D vma_replace_policy(vma, new_pol);
 		if (err)
 			goto out;
+next:
+		prev =3D vma;
 	}
=20
- out:
+out:
 	return err;
 }
=20
@@ -1042,6 +1050,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1057,8 +1066,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
+	vma =3D find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
=20
 	if (!list_empty(&pagelist)) {
@@ -1188,14 +1198,13 @@ static struct page *new_page(struct page *page, uns=
igned long start)
 	struct folio *dst, *src =3D page_folio(page);
 	struct vm_area_struct *vma;
 	unsigned long address;
+	VMA_ITERATOR(vmi, current->mm, start);
 	gfp_t gfp =3D GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL;
=20
-	vma =3D find_vma(current->mm, start);
-	while (vma) {
+	for_each_vma(vmi, vma) {
 		address =3D page_address_in_vma(page, vma);
 		if (address !=3D -EFAULT)
 			break;
-		vma =3D vma->vm_next;
 	}
=20
 	if (folio_test_hugetlb(src))
@@ -1473,6 +1482,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	unsigned long vmend;
 	unsigned long end;
 	int err =3D -ENOENT;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	start =3D untagged_addr(start);
 	if (start & ~PAGE_MASK)
@@ -1498,9 +1508,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	if (end =3D=3D start)
 		return 0;
 	mmap_write_lock(mm);
-	vma =3D find_vma(mm, start);
-	for (; vma && vma->vm_start < end;  vma =3D vma->vm_next) {
-
+	for_each_vma_range(vmi, vma, end) {
 		vmstart =3D max(start, vma->vm_start);
 		vmend   =3D min(end, vma->vm_end);
 		new =3D mpol_dup(vma_policy(vma));
--=20
2.35.1
