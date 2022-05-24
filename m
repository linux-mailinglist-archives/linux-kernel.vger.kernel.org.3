Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E4A53301E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbiEXSKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiEXSKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:10:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275336B038;
        Tue, 24 May 2022 11:10:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OHnPZX024032;
        Tue, 24 May 2022 18:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=325yrMMbehkZEn6zA72TF6qR9zyDx3kuMg4wtewztJM=;
 b=gzf+Mq6B3E2VPdNBn+TttVvZB93hhEqW1xfpSE7yFw+5g6Z5aFIiSkBA1N2y1zApEd4A
 /9ruCOjuYxeuHrhLPm9sjWoy7cfnOYISKInTnfs4lWv8ivAcmbolWuE7sg3XpvpvD/xd
 0h/kNisz3kCuql8wSZ/yhbN/21dP6gsJcM6ZAqjALCx2PlOk2gMFDEOuqBw6dJsQES+h
 3kWNxlhFv8AaBCXBJlKQOQBvoqlU6b5+BOw+ycYxPgCOfytkZbYQC+1p2suYj50krBTx
 n9FD/PmRoLvKG/0Rrr8MPoU8fcvgHezwo+DbEYHI4XCRg2iCP3vJLK6cYPlrAjOIx/hA Mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tbr3e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 18:10:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24OHwL9A002843;
        Tue, 24 May 2022 18:10:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wugsgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 18:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg42kTebzN3S5tA7wv0w12yF0y4sBjyzAwVavgYy4pXLTX1ykdlK1breuqzUvVy4OT2HTaiE7OuWW+PlmBGI/V2CVeeEDWxFkdRakKfACWgb0xxak8OPiwaVR3vsm6SjjTIeouSeI5SoB70NY9QKRwy7IZ53hdg9zRu2HlluL7QnkwefYNEbb0SExM5La4kuAvKptthTd2ZVEYf1c8opxUmeWT2eYrl2vAVPdsNAG0O/fQqZzEO8ue2vRhfiP2vCQmjexJ4CYXfy5/TUupmEsbqZVw+MB4dQBhCByCy3uKD0ebgFC3BGRhj7gQsWZEZeNgwVjj4ufVMwmKbMQXn1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=325yrMMbehkZEn6zA72TF6qR9zyDx3kuMg4wtewztJM=;
 b=IOl0+/oxSgEFvZsOIp8KeYsmINxMP+yr4VQhSmxhCY1THq8sGjNF65WUTzGS4gbfy0JQ3GB42c89phZFq2hWaw//+B2CgyswU5y0o4SY6TojG7rULmHNNKSoJ7OBf0FT7oNMdVLifodTSC6WAWwWYvx1eU/OO0wh9C1qBpGptTZcMRiTWXJ96LZNPp+ozDUtyuL5HIU1fP/i+zmM410afoKcs3lAJjeuD0OfVFj881AIcm8M3S9YhOt6AC4jEuGsRfBSJkut59I4LUeULszXW559nrnsw/grpq+XEwv0MCov4K4oOKiuz5X8jIeBLY8VGorcQIS0Ugi4+mV/FqW84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=325yrMMbehkZEn6zA72TF6qR9zyDx3kuMg4wtewztJM=;
 b=Q1ds9hoWGglqRyyYNn4Kqiv689f8vzhPvSowXBQxYW0ymjy7a/MyJt8zLOGRICH0+am/XNJbZYXWlbmoBr+Mx/62EtLIV/CwMcWJ1HTr2KP50VSLshiKANBaVoKKDxAnjrYtqvz1sARmQDP6Zdq3g20038dVNvGtiU3OV672vdM=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by DS7PR10MB5261.namprd10.prod.outlook.com (2603:10b6:5:3a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 18:10:18 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::ccc1:c080:5df4:f478]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::ccc1:c080:5df4:f478%3]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 18:10:18 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Tom Rix <trix@redhat.com>
CC:     Nilesh Javali <njavali@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: qla2xxx: remove setting of 'req' and 'rsp'
 parameter
Thread-Topic: [PATCH] scsi: qla2xxx: remove setting of 'req' and 'rsp'
 parameter
Thread-Index: AQHYbU+pycrjMrmuMUGpDqoT9CGnB60uWGuA
Date:   Tue, 24 May 2022 18:10:18 +0000
Message-ID: <A39923A2-373C-4EF8-997B-2A12821ED4E8@oracle.com>
References: <20220521201607.4145298-1-trix@redhat.com>
In-Reply-To: <20220521201607.4145298-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: babecdff-28db-4b2f-ed3a-08da3db0a8bf
x-ms-traffictypediagnostic: DS7PR10MB5261:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5261A0EE9386118F4CE5DFACE6D79@DS7PR10MB5261.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ikpfur76Q6lC31MTla1GwwXlEcR54qe1EdlJ7ShKjECJs7IQkd3IDJSBRu2WBLbEpCl5EQ79ZlBJpiFzHLJVHbRbE1+WnZTd3KmOVr86qC2p3u4W+IBPBflVcww/VIVquprMPFEspNC6RK9RfqXmeGTqlThRdTxEtfKu0TPYJiVQT0S3B8xhiXQF+Pyr7Cr8uR+0UpvDiRINcazmxxhSxXCr9nk7oFes+LNL4z4Ts7cvj4DkRHmQsHp4JnUYq/9SvkRjNubgzJCzxf+IHpFJGKyF+wVXtExoIddDPwkOLou5fmyHYoVtUTas373gX6HqXIKNXxEAo9XwV3ruA2XszqSChiRyjlDyOEu+3K5PeiBK/vFw2jYfFvB6K4xw+TNBwACQkGAzi3PW5qYySv9jUObrcAroFAS2Es+vmFngiJSdLy11q25NR8uO3/XBXdgbkAIijzT/0L7JHPoG/ocMEnPapZjYYB/8Q0CBhz+yCIenrnscbipTuNeTWeVA6IflZSoKi+lumKKN7VvgchwPQioZptiEJm5uRxGHiIO0wQuvfI8olbScnd7cmFISRDUhy6bIbH2g78aeGrHkbdmhXxRz5iYngfc3pXsmlXi9qj2wY3kUzI+gehkr2C4TPgBMtqPQSFYEjuyRSulpTrY8QxCO31whCnsegztkFTUwIj7kC9vnt3X7vvW/p1Zc5MK+owgJAGmp0fBbtH8RE/w1ubyUw/Wqblu8yNGOqv8HbqQDCdExZ6nsr39OTdis1OEY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(6486002)(83380400001)(66476007)(6916009)(122000001)(508600001)(33656002)(54906003)(26005)(44832011)(64756008)(36756003)(76116006)(38100700002)(71200400001)(91956017)(86362001)(186003)(4326008)(2906002)(316002)(8676002)(6512007)(2616005)(53546011)(5660300002)(6506007)(38070700005)(8936002)(66946007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?310Ih2XWcJA9/D00H3aXsvodvc6ggbMQV+aCIUHOmSxy1C2mMYLCJHKFDSFq?=
 =?us-ascii?Q?ygBdsA1lWmOvCEizflHCjslGRQKkNOJbrZQVzG3PEJ3NhNpwAuk37KMNDf1g?=
 =?us-ascii?Q?byfvAoSEJ965OEopr2WPjA2eOqaI5VqpdozPwponTK58gkjnHRJ5iN5jTlO9?=
 =?us-ascii?Q?mU+1ndCjBaS6eL9cfHsJb8h5Q/4nEpwLNQXiUd2JSRQYi5nZ8JNqu+CK0jgK?=
 =?us-ascii?Q?w9ThP4ZMvr2+DCMHK/k1Klhnn+Q2dQreYHhUvPzGmqfEbrSKoEr45SX3iIUo?=
 =?us-ascii?Q?IwMO57bKq6Jhmzp/mgWEFbvEDED1JprdGR50cjSd2pFJhz1iY6ovNLZmtXVb?=
 =?us-ascii?Q?f+cC8pjve8azY1s+qOOHOEMknMVk5ujpKTfJVAFvguEtnusnklWPcFdOjaXi?=
 =?us-ascii?Q?inJLFnMgsgHMlPio/R83ev1v4Q/JL5PQC66CEXCkor4JcogdYpXsHn71eLAV?=
 =?us-ascii?Q?1evHoigiaF7NjkotsvZoBkSeQSxIV2tXt4sz111GZ3bxjOCfkgG0cdxPM5+3?=
 =?us-ascii?Q?rnEX3Mu1CConVOJWOda944HjGyGrb0xCuoVkRXtndMl+1SUxZkrkGlj3sHy0?=
 =?us-ascii?Q?p95Abw3dELafMNqfjUwIpT2ClSYzETkWONyskeLIDfW6ggW7dXBPvAgluooF?=
 =?us-ascii?Q?Evbvf+jsGXxivNByE0hdEEYHOnga3OW1fgl5UDtxJXAH//rKBcXWZHuB8IAS?=
 =?us-ascii?Q?kWOwVJCM6S7KRfII67ZUTWDwvxLeEAms2DjdhQHNcQHUyEUaBEb0+L7Itfor?=
 =?us-ascii?Q?G6A+0HVyM0ZMB77qEFeijmHr6T2BU2PME903X/LWuQPp02KBNDN8wD8EiEnM?=
 =?us-ascii?Q?dS50DDMu+gEG7tj7HV/tx94UP1hsAWGZN9MeMZS1zf1N7INM5vA1BF8trpKV?=
 =?us-ascii?Q?5ODbtCarF5ayj/h+1C20V3mnta+Y4MVceyY5fbcvreBYuaN6mWe+vcGPHfo4?=
 =?us-ascii?Q?/X6q5oTA2aIi8oAkjgjdd4wNcUK2pbaiXiVKe/K36WLtujgG2cVGO/jXEYAx?=
 =?us-ascii?Q?z2La+CMVa9/gPKgJaecMu5urLl3rTHDIRWU3XF2wXy5zsNlCSsL+5rtrpm86?=
 =?us-ascii?Q?EYkymKAznXrQlGELVSTK+chgVNMcmwq8O8JO6C4YcEKo5nZ0s+sBDzZhCGu5?=
 =?us-ascii?Q?QagsDpinsUReLTzWB3mauOZGQ4zg/ThzzhzRgLm/lCzCUuZxnisxBVRVDZ7C?=
 =?us-ascii?Q?UhIRQe1gf6VsHgY/ouMOo1EzSQPYrm+5S2EFBUnxKuhXD2IPpFAOV9HC5op7?=
 =?us-ascii?Q?NF0gsTdt8nUsa+Q3vpDqPdCUoAk+mzNAKn/mOx9ztpU+yNQIgLz3Qedo2Gmg?=
 =?us-ascii?Q?yuZt829fpakJo5FiQpTGZb7mukX0RUmuMjPh0xPCJTY+IC5CkXSj6mKwCzYN?=
 =?us-ascii?Q?W7BhhLc9idtWnfLby3wG5QJogQ4kyWJM+rqN0A58QaoDTy12qKBXFoxjwgsC?=
 =?us-ascii?Q?HgCiZ5sWhVEbnttO+U1UnO5Ude4Fl+jukR7FL/zVwgZzOPdQZEe5hNE8mW7h?=
 =?us-ascii?Q?QGsypLO8ui9x2VEuaKmEIv6OnsUfNDz+poSMoum0ZybxMzKbhoT6uvLZRl3k?=
 =?us-ascii?Q?ihPoHvvga1OABgWbXjwDsuuoaZcl97enLxKV8q7WokgmnjW5DRWP7n1PcDIq?=
 =?us-ascii?Q?rlHfIbIgX3boQnU9EW9XSQKQWOAsaq6fbJ0vMhMbJPWFF30A9U+vJOrEiM1h?=
 =?us-ascii?Q?qCa9f/ZyLiDq5wdjmYnqwJEwHcd2Pe9ROrmPBw/kODETsyi0pNcPoobtRXrQ?=
 =?us-ascii?Q?JkZC4ZeiGSVMRRF+F1JCPNA/do++9HoCIxEpOWIQ7IQux3shX+/O?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <337ACEE1798AC247BCC31B982D82528E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babecdff-28db-4b2f-ed3a-08da3db0a8bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 18:10:18.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UmRTVVGzX8/kgGpifv1N8U5KZjRzjLEr6Js4x+UMuv1fQu84IJSxiQcIFDK+JfBEY/FHzVLoBe/ENpyFlIlnafLX9iBDb3crdlmkm+ysP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5261
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-24_07:2022-05-23,2022-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205240089
X-Proofpoint-GUID: H3RC6gQhm5vR-bI4kjK0S_WCVlkvs4il
X-Proofpoint-ORIG-GUID: H3RC6gQhm5vR-bI4kjK0S_WCVlkvs4il
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 21, 2022, at 1:16 PM, Tom Rix <trix@redhat.com> wrote:
>=20
> cppcheck reports
> [drivers/scsi/qla2xxx/qla_mid.c:594]: (warning) Assignment of function pa=
rameter has no effect outside the function. Did you forget dereferencing it=
?
> [drivers/scsi/qla2xxx/qla_mid.c:620]: (warning) Assignment of function pa=
rameter has no effect outside the function. Did you forget dereferencing it=
?
>=20
> The functions qla25xx_free_req_que and qla25xx_free_rsp_que are similar.
> They free a 'req' and a 'rsp' parameter respectively.  The last statement=
 of
> both functions is setting the parameter to NULL.  This has no effect and
> can be removed.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> drivers/scsi/qla2xxx/qla_mid.c | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mi=
d.c
> index e6b5c4ccce97..346d47b61c07 100644
> --- a/drivers/scsi/qla2xxx/qla_mid.c
> +++ b/drivers/scsi/qla2xxx/qla_mid.c
> @@ -591,7 +591,6 @@ qla25xx_free_req_que(struct scsi_qla_host *vha, struc=
t req_que *req)
> 	}
> 	kfree(req->outstanding_cmds);
> 	kfree(req);
> -	req =3D NULL;
> }
>=20
> static void
> @@ -617,7 +616,6 @@ qla25xx_free_rsp_que(struct scsi_qla_host *vha, struc=
t rsp_que *rsp)
> 		mutex_unlock(&ha->vport_lock);
> 	}
> 	kfree(rsp);
> -	rsp =3D NULL;
> }
>=20
> int
> --=20
> 2.27.0
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	Oracle Linux Engineering

