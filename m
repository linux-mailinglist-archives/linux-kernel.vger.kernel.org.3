Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FA5AF4EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiIFTzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIFTwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B495A83052
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id9Kd014060;
        Tue, 6 Sep 2022 19:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x2EvKK0ryov7/SJLvusaJXVRPfpdE4B7t1oHpy9hvnE=;
 b=ZmWzpjWBG09Gh/+LBXpSj73pfq9WErdPt4YiB6W+5gvTxQ9HrLvZ5NAWtFyeOLHkFrIY
 9JWhdkWLguMzsBAr7ps5YsKHfnVALnNkAN632btk3KzBMQwG4PR3JkwgVYomAToyzS+I
 B+a7792oDXe0BP5VoMRYzlglPNb71NrzAPMuC3n9Ob+srUJNBBd8seHjJNsTXKoXhU7P
 Mj2QgW7THhqNLPFtC8sPV4+Cwq/RUETMCwDYsL+6BEH+YC2y4RY5YLoJ0wrrSN+SaUKF
 HnP4vXCDblZARxaOg3N1xbEsaLvwt3+C5pJoIa3VwWu+INDosTNDg4mKhXBhGKG5r8go tA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2eyq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H2KIj031383;
        Tue, 6 Sep 2022 19:50:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ajns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZaVDKQfBkzRpsE3frkv5vLOVzQMCXW6zu0voN0hXFrJy4U9xVmejrVnGQOfVPxNLaH2wk/bWBLFHz7xbuokht7TzJriphPAPwwvj0XEgIaPiDIm3h6maKI+mJCDEp2l/Ly0vLCFRrWeHaVyeX3ICfdZgvvrF6sbPzgsOsUt1NZVqrp5izaBrjYFApzMJMSF6+LICp5IPkaDF0v0GIYCImP0VIO3SDWkaO8JkKew9bBkZ/rUm6wI83tjpcI+WlxB8SR/V9n6wRO6HYc7XodapN50+zEQBc1holFlEvYwubnETq4oiSwiBnpemQLMqcrSlqUhkjP0uqUnjSCvJNjlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2EvKK0ryov7/SJLvusaJXVRPfpdE4B7t1oHpy9hvnE=;
 b=UWcItsWfKxiTMjDcTkvMwWlp3xFqgy5Q5wjZS1tU+OUnhTrDGIb84q7RzmoXFdssWsUnXnnYFYbqTervcLbGZjmOlIGLwqNGEaHqujQR/kh4e3nAPSsbSEhq13cLQHn336poMiJdAd42FiB1o0nW0vPJWmKrtmudKItTcAZb6bJyhKiM8eQObsJIqrpzQzQ7VxkoY9YnNV2rhWQbvHBvupOTu/0HuXBruxlzmHf8FLl5JQ0e4vhrSxDhbM5POeKo+yKnQ2fFAEYLdqL20MnGqn3+mtm/Z7+9xkZBg7zMHMO9bMhTbdQPU5Ogot8o7J3O5K60qwkTotz04Kdnuzwp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2EvKK0ryov7/SJLvusaJXVRPfpdE4B7t1oHpy9hvnE=;
 b=W7MG2TYXgV8/WJQbG8QqODzgXSfF334aMMaUE5UtCI4ksZTT+fHkOkiKkzMmP+Sa0/txfhdRWfNaXypKSFjVV2nomTZ0f63JibWW7IqPGgPHNckpNlRnjTHem4WDeWDTz8UDF7XJF1TyO67xn/2LNLIl8zYh6p2DiAwz/gqB6ac=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:50:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:50:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 60/70] mm/msync: use vma_find() instead of vma linked list
Thread-Topic: [PATCH v14 60/70] mm/msync: use vma_find() instead of vma linked
 list
Thread-Index: AQHYwim3uq39oyt+IUK/SbpqgZCwTA==
Date:   Tue, 6 Sep 2022 19:49:03 +0000
Message-ID: <20220906194824.2110408-61-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41f0d6b7-59be-4220-2ec2-08da90410799
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: leZ1mrKRcBcyTp52tOZmnVozsrSrEkZqscrUdExB/D0vFb+3/o7EDXXjF+QmwXB40D8YF/rkihguIsL14TKPPY323z0y3QmEPzzuc6Ec440CwFHDAVg6dlbbxjiy4jZvkMa7yKpVkj2YTB93UCeuD/FwHnnxHuBiYiiKg81hIwL0yB+jWyqpIalO3ICyzQmzaSELHkZDR1czUqv2eGw5LV6arPvzHwofUXjwKu35OL67rZxrRRNHo9vXPoE1sEb0bSc1OOxBhYQg2TZJSe/t3ODs0Zt4uO5DBGyoobwuqf7a/T+soK1dy33YBxthtP0t/hCoeqtQAB5ZjxKks10jg//SFnYlu3Z058IRdc6017Tl5FnhGcpu1bkln4zvqqKxxti6IBKBRLE+BweFwHUub+cF76xnLEEAJIViLntSq7z+2Msikp4qrAD2Lu+TgtXhi3VpIydyrZfGfY7D+EiM25q+OEmyFA4jGUTbMn+lsTmjK2ZJvr2KiNmy6VtS3ZO+2VGUMDz1JTjUs7OF0+4RF7xJTQiynb9dAtblrGUJ7Fvu6t0mDFMqIj0pdKxhndmUsPA92nc1QwQ9BmJbYlmVISF1QSXHt8trDruUDG4he8zI5xUdxPMPkCcgDDc6TLWjE8pgviHd9lw+3kGvOj6xF+c2puZouJJRs+lgbqwUpgAurzeQvu3AWBtON2QgN21eZ+UpskL6GD3wDuWxsiUSTqKtmzJbprbyIxroeGYPnPtNy9U+ihH/tYlug1ibBS1U1RcUbA6RXt9JpxItuSnNug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(4744005)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OUMIoiXTyNQQeBX2d4hBMQoLlTKZkw+YmZ8QQIctq284Her6zfPhMTl3wi?=
 =?iso-8859-1?Q?Oj5+hXiJrhiSk0ZiBfQnRxyPctayVKc2ItXoAO8fcrBZOS2vSslsr5lK6E?=
 =?iso-8859-1?Q?Axi4NiiHOjFKLOX3LxWul5hU/jgpEtBdjdPWy5gHqUo7Ac/4JEChnHF8Nr?=
 =?iso-8859-1?Q?DpgTpKOYo4hVLtCUcEoxH4/Es9GrkgMnsWzwEa/JF9dRZRcfAm59QSp1Of?=
 =?iso-8859-1?Q?/xmXiBwj+HXN/C2Z0Sg8Q7bUHiBWTqAL4wD5yxaTf33lstFqKyIfxFjfWT?=
 =?iso-8859-1?Q?2ntTM1db3Bouo6/HsgADUlQYQ50lg5gf43m371Mfz59EnYEszxa6QakB3y?=
 =?iso-8859-1?Q?YPXBJSBzrqk3P5fpjOHF8RND9fbbdTgtglOih7zFzDnej/NWCuWyYNH2uK?=
 =?iso-8859-1?Q?T6nSjSwCW+uIbysEejYp3va1jsGeFZARvWU6UHFdzdQj1H1NyWgirFNqPK?=
 =?iso-8859-1?Q?5NcA7ekI77BIIjwbY5js/GqgUlaUnMgBAZbuPWmVbQ3g6HJl3YD0u10JJD?=
 =?iso-8859-1?Q?TQbtKBBAA4GQRTC7wjx1JrdBaD0EDdQ5u5+Y+wl5ZPctDhb/dWCBuollRw?=
 =?iso-8859-1?Q?zAhtMGAzXaR2yXJvVTFB6LwxgcbBa/Wyc1aeEcwh8WZN+6+YXimVGSxrYV?=
 =?iso-8859-1?Q?V5gL5eTWHfcqiwMmNB5XXk+5XbuXa/FVuRlroeCf+S02wFusGWNzFkxeIa?=
 =?iso-8859-1?Q?7FbqjxG0xrCStF3noTxTbIf9Ztcc2xZx6dextKO5QQvjnBGuZmmp140Jh7?=
 =?iso-8859-1?Q?r/aDCYr1AAncTDHhQL/G969/yoFPXFspy0KVm6eZJLk0Y4Q7jhszMZ0k38?=
 =?iso-8859-1?Q?Gjb9MJbNn6QSwmECseK68HpKi0jEFLFAvAnVLO0kSZhYy7mUGvxlOJDH3d?=
 =?iso-8859-1?Q?h6trjqItAXW3CizWbfZBPaYrGAjOJDtc4FwyT/ihA1nkrt5yhCYH5uKeg5?=
 =?iso-8859-1?Q?9abemCMWytEu0Rk7MNPZonnm0fINEwO6YkQlDvvnWoSg72Izx4Kl72QNgo?=
 =?iso-8859-1?Q?piUcuG9ECU0vCLn3rxBSgPTPBUOa4d76zG+zbIUVj3FajjNv7BrKt1PgZu?=
 =?iso-8859-1?Q?8T6yYsccFwOohiERPJ/S2Qw+wonbznlDqYiaRBW9J9hNKmC14ZSriqIC2H?=
 =?iso-8859-1?Q?NWDFPTIuayzU4Dus2KAU//ABxte1H0bOp23CdQOWcA6GdCJ5AntClEbwfP?=
 =?iso-8859-1?Q?WAgaBTs7759zATfR9PbCaxxdj5Cy/vTAvos2SKMbevgV+BVh4P62XpNwiS?=
 =?iso-8859-1?Q?Gdqk2Q/Sxbk4ODrEirqrvHhrcc7IVrfTXqL3YzEzKo109ej1/uGR074Eip?=
 =?iso-8859-1?Q?oxLG2pFJeHTVJzVl+t/9CiyVHZISOby8TguUVdOVW7sGQ7GepHsde+4Rbi?=
 =?iso-8859-1?Q?fQKVkAv9VHgEBM5b4Tdhi+Cw7vHDpXBpXszgcr2S3J/5lWityj6sKcZ0bY?=
 =?iso-8859-1?Q?/cHrQ8XDYCTWJg4sVIX+eoeHKNZpeMZgxGkLlzgSM2DOVgUBchiiLMPoPs?=
 =?iso-8859-1?Q?dMje1EVkRf4Y4/wpttnKy05J9+Ma1ZM6cobDdsc1/RV6ay/4QPv5AIaABg?=
 =?iso-8859-1?Q?92l4MaZSVtR7+A8IECDaTwgjatTYxeM+UB8CwmPn50qDo3hTYSJZqgTtfW?=
 =?iso-8859-1?Q?8cqSWzI9MLYOZG16EftLcDLmmf2Tn6eLHROaMJpcrszq5gBAeyAQJ1aw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f0d6b7-59be-4220-2ec2-08da90410799
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:03.5683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngnfolgUmVnc9yJf8jJwHXRsJylg16K2fqLxxAwLUTaLcPUkIM6V3r6J6Dx4YK9NTT3SXxFe/m8QPCBVvfV1aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=935 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: rs9P5sWWr5iSS2xaKblS9oAkKhJwNGGv
X-Proofpoint-ORIG-GUID: rs9P5sWWr5iSS2xaKblS9oAkKhJwNGGv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove a single use of the vma linked list in preparation for the
removal of the linked list.  Uses find_vma() to get the next element.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..ac4c9bfea2e7 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		}
 	}
 out_unlock:
--=20
2.35.1
