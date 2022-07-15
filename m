Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB55767D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiGOTxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGOTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:53:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E867E80F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:53:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGHe06027311;
        Fri, 15 Jul 2022 19:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=/sK8Nz8MOZx1yWmE3OpjL3qmdH8QsNr6iblZyVBnqeQ=;
 b=mFVPqI7+S8E2B/eb66NFYV/wVq+th9s58oDcPPYJ198owenSYsCVw53qkUJJ/9kTDGxR
 zfNPjffgZBrDmCJOD8O23wNdHoiePrXmE3/Nav10RkB9KPzuwKJXKiokQp3tiKMYW4T4
 5/mrwwXps95xvQmkSoR2hfXQHAlXguwRwXjJKc5lhVGqZOq0XtVHmIJfeglyxa3kZqEc
 R2UIBmaEQmyndvnS06e3xIFy945xCv8p2tXHtzm08zVl+2j8/X8ayMfVIytDtfa8BT0d
 1F+0DcRj8R7eEzNCCOxxWwCipq1g/PVtG/XSTDVxRssoE6dfhow4an35mc+kQuxwgv2w uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg8pjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 19:53:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FJlfeF017670;
        Fri, 15 Jul 2022 19:53:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047wgga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 19:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXt0LOSeqU3u35zpi0Uu6MxuIHP+oVmyyKAxpY5s37eMZFWEzyhNQ9eXuHMTJNH+T/GY81uqXpptB0WwzLdf6GZyAhtJGPbZN19qPfvmzn57rOYwIKwf3QVe1VHMZ/AJfbeNlvumSmC/xurDdaAhtN7EBw+ieaxwJYJLxtxDzZqtGmLsEyoG/INVCP14vkHVmBioBv/dwhdBJF8UdrEqTJ7haNxuRGsehPHxRcZm2TkQLjYsgQWoBePNA6+ecyarmuI3HwDS/o7M5d0/GYXyi2RFAcOhJIIYTrrikJjzcs5A1F6F/d9Xu8I1Q6OYuJsawT5T7xa+LAd1DD0wys8urA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sK8Nz8MOZx1yWmE3OpjL3qmdH8QsNr6iblZyVBnqeQ=;
 b=IYmgZHKzXW5A5P/XZHlzgm2BwbagP+C6KD8ahrOsOccc0S9CbU3FERHYH5LdnpoPj4zFGlIwHiIqb6hjR18/bsHgrgc1gOsm21BlxCvHLSpwKrDYfLiV0Y5iHm4xoqrkXlMK9nTwqntJWVESd3H+mrlOHFv9ODT9QHl9FPH05NWHZdemK7BxBaDF9viEl7g2cQXalMLDFKIe/i4qCK1JGcHSX/uZFxEFbw2dY+RhtFdfrynWNLbC50ZctyUsC1j+XQFodFeFrUen2yAm17CYjZY6d1Lnz/oEEyDp25d/z+Bn+AMd/I49eUQLeelSu1rJLmIDKMhlxzeaDrfNQ4PnHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sK8Nz8MOZx1yWmE3OpjL3qmdH8QsNr6iblZyVBnqeQ=;
 b=kobJbcSeyScFG8e/+cAPdnhVbJJugLphR3d1RbKrpE5wVNaWxRjd0fimH3+CkCRKbgdInIu/v7sZMQSyPFbvkbpplxeRtYAH9xXSKLaFEyumlWViQs2KzZmuTZPjutPv3V74Pd6Ba0VP9IA1HQPSAJgSKCMzNRHkI1u/vshekug=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1526.namprd10.prod.outlook.com (2603:10b6:903:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 19:53:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 19:53:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Thread-Topic: [PATCH] maple_tree: Fix sparse reported issues
Thread-Index: AQHYlfsoLhkzbf9CQkS2b2OLBBRjJa17+qSAgABSigCAACjrgIAAH/GAgANG+YA=
Date:   Fri, 15 Jul 2022 19:53:10 +0000
Message-ID: <20220715195301.r7ozt6ph2scti7vz@revolver>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
 <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com>
 <20220713132926.3sl7gs67dyjj7kit@revolver>
 <44a478e8-2ccc-e82-bd5a-172778c01529@google.com>
 <20220713175013.aoemaelds45aavc4@revolver>
In-Reply-To: <20220713175013.aoemaelds45aavc4@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13cffa46-494a-4be8-8ed6-08da669ba581
x-ms-traffictypediagnostic: CY4PR10MB1526:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EaSKPiUN+SacQP18kHwQF9jI1O4gO5MFm/QpFjBoCXMzkPMhEYaz/yl7JsVaUvEXPv/RH2a74qBcqr2VEno5c6musQykNO6zqwkI8UcbFDxpcHXgUGEwM6RDF/ctW7HzydRy9wjU1/dZmDcuagV+rakX91YWIz+KKOOuQBPTa1b0pKqEaaLSbbF3yFz7G+yaizBnLo0DL7f6GrfU58SvvdUqu0uRoX7unP4//cKxYhrDO1ahTX6JsV6hGwnV4O/C5U3o54hjN3PgB7wtQqbR1vkhP5As4TfMTlwIEWoej7QFy/Rt+Xi7e7FyQyEJ9/bEOx6KB6KWTUCDT3BxvmbV4uCccJkKYGmT17wBUNMDY8+Yq1bHap0zCf8/KwQp8JXkz7Y5Yhf1eTNMGzSRQT9A5LBGQ6rfcsby/DmthZlrX1CX9c7hC5Azhf4SMRtebU4sAdAiJOH8YeB+4SqYKHcuOg3DGfLZ+VeFPsdGw4ZqEnb6Mg3UjDEWDDVouuhRxHfTXrqV58QJ6LVERhxmphpCIcEIDUlDnhS133UHS7zUnWBHYzN8XvidFqvXzWDzsjm3aVYVi+dCUwyQyYcq4dNXCYQpZxfZSRXYvuaWKzVw7nH8xymwuXvnkUj6Va+TFHteQtSc660A1nyJQgWY3R2SthxuI6kszrEV0vI8hskfB9gq2wmQYps+s4/cDS5MVnjsdtzhgZPuAJn1UBcipZOY465ktVZX3GHZQJmNqh0SDbn/gFLm0oVa1xmfsqzELxYZDiKKkjE14REbvWnYQe7/OeuyALEJ+zVXYaYY2TGVWkm2FLwSQZNP+FRt7niAvheM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(39860400002)(376002)(366004)(396003)(53546011)(316002)(41300700001)(91956017)(26005)(6506007)(110136005)(478600001)(76116006)(71200400001)(2906002)(6486002)(66556008)(66946007)(8676002)(66476007)(66446008)(64756008)(44832011)(8936002)(33716001)(122000001)(5660300002)(38070700005)(86362001)(38100700002)(99936003)(1076003)(186003)(9686003)(6512007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KZm5T1MZiHqgQbcxVGDp8yRvWScRTeC7dMH8wsEdyqsfLZ3yQ2myn5lsS0nv?=
 =?us-ascii?Q?LDejAwFeIuRC/bGG8BT+NupX7khSAVvQacREexneyaUVXQTnHTUgZsB7wtYn?=
 =?us-ascii?Q?iidVMY0mYTIAi4EXI2Y/i8gc9TiUBTs3GJicxBhYQcxR7SHLAHM6rZGEc3M/?=
 =?us-ascii?Q?S9aJGmcgXncOPF5TKzWaigRk+jQTAeaUvSNBZEH29KSFrxupdKTsupMp6QTX?=
 =?us-ascii?Q?ZfzLyfQtIgxkaeP2AuSZrjO+U6HsUDIl0LhJHs+OCu0AP0BwpPqVejx7gZum?=
 =?us-ascii?Q?CELSvbPV7Oqr5GwwQIHfsH2vOQLUvNsCP6w0UUkixv+Fr1w2qR4xVHVHYXcM?=
 =?us-ascii?Q?/bPawDN+sSghpt4A+9mPVb04Z/ipqlfp1LzE8zJYWDdqQMFNl50OwB4oZ0z7?=
 =?us-ascii?Q?UcrUJpkG048AwKGnV7gtUeW8RYpGKD3krCoFeBYHac1PMQRmHbg7R4UPNtaZ?=
 =?us-ascii?Q?h7rtj2NRCVLIv0ykEPGVj+9HRGwx+d/y/LiUl+JHxAm4KvaXb9C3zN86BwDA?=
 =?us-ascii?Q?hJ7yqD5T6E0HT+a/+UgeZyDmUw9QlZnyjQvmD1JeFwB1x67kjHM6JEGrVh4F?=
 =?us-ascii?Q?PZ/NY8Fc4Yg9x1QOs1y7CQZclRbkonF07VblUbjtWjEOnllLpE9gAnQY97yr?=
 =?us-ascii?Q?vPZeaAQnI6oE2GyOllzeQGRyzz2C9L0zCajKmTlvQZw6HlaGan8C97VByNno?=
 =?us-ascii?Q?8VB7g+yKw3kxmRY40GuogIcw8+YEU5clSvQUywlqFO0OGePC6v5BJXHYuJP9?=
 =?us-ascii?Q?LQBiatUIqLLlUkB8v10UjvSZxZtnrXYdW5NwX+p//o0A1I6JiRRav3tYQ08Q?=
 =?us-ascii?Q?I5NJUwp/8ellFF3swd4hovcbZ3Wd+9sxFDE+vKFNPUP5AOdFWoqOpWwy1TFS?=
 =?us-ascii?Q?waf/Wm6Nd0JkDDjZjEn4W7Nyy51selb2NHJOLxexHqGcXviKHwU2wxvw7gNh?=
 =?us-ascii?Q?SJYMDzV3ZrDHQF961UIiYG2z5UtduCt0fIboOBeM7CxiTLyBdWvbnOVAXIhb?=
 =?us-ascii?Q?iTgBfn0ua0o4x0Y/v1VMSGy10Uscu3bYxBcjBAs6/g5azG43btHEN7HGP6iu?=
 =?us-ascii?Q?gn5uUNoOR4q+HtG1lt3uvERRwj+unWhuC1fTJ5burFyV40uCZeOtDPP4MKtT?=
 =?us-ascii?Q?am9J+vN6gNT4qlHPkq1EC1ZH9ofbVoEEVWvbcT50r/cDS/X5eb6MoThxNdOk?=
 =?us-ascii?Q?lFHGZUAjZr4SNSb5GFUlw0Lu1SNDJ3LJ/7+/7P19SkRTX1GxmXfn9xqkZSnr?=
 =?us-ascii?Q?1vWzxfpSfFcKsNOOQtkvcw08zr7GSmrSXRDG6gyTi4TVIIjzspW1PaWZNTR/?=
 =?us-ascii?Q?pPwIfLsogRprPpqMCEiNjN8er/VXLSwD3DRMLnEN0TskzQO93PNUxd2jSPAZ?=
 =?us-ascii?Q?ujiSE7hqgqxZRG2XmAMw8QvvqFF4//trD+sI6QW334TlBZd0BXzg0suvEYtt?=
 =?us-ascii?Q?OZUCoJcRQZOxEpZC3a+1RBhI9Mk3LS7CZoGYZronxpUCCunmEVQr6RG66mNz?=
 =?us-ascii?Q?3xP+e4NYhPgYD+mMPFP8VDVqmbdBkZKrI1swn7+zNBwHeLocRfYop0iQhZEO?=
 =?us-ascii?Q?x1A7mmbQ/7CkciLfCtTC9MgiiK0BVDGBQqJL9FwYXISdB+acORUXIDj6ZjMu?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220715195301r7ozt6ph2scti7vzrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cffa46-494a-4be8-8ed6-08da669ba581
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 19:53:10.8573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8aS1B7PaGIIKoy331C3cs4VA2awbhgR1/ad0gTKn3t96qlw3HRYtamY4sxfz/5IusBJ87l60UzTtkqmTXlX1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1526
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_12:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150087
X-Proofpoint-GUID: vcxecHcC9T8-SjmSZU3-HJqUzkxJf72z
X-Proofpoint-ORIG-GUID: vcxecHcC9T8-SjmSZU3-HJqUzkxJf72z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220715195301r7ozt6ph2scti7vzrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41AD1C351EA23E4390EF976D8EFE06FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220713 13:50]:
> * Hugh Dickins <hughd@google.com> [220713 11:56]:
> > On Wed, 13 Jul 2022, Liam Howlett wrote:
> > > * David Hildenbrand <david@redhat.com> [220713 04:34]:
> > > > On 12.07.22 16:24, Liam Howlett wrote:
> > > > > When building with C=3D1, the maple tree had some rcu type mismat=
ch &
> > > > > locking mismatches in the destroy functions.  There were cosmetic=
 only
> > > > > since this happens after the nodes are removed from the tree.
> > > > >=20
> > > > > Fixes: f8acc5e9581e (Maple Tree: add new data structure)
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > >=20
> > > > Sorry to say, but the fixes become hard to follow (what/where/why).=
 :)
> > > >=20
> > > > I guess it's time for a new series soon. Eventually it makes sense =
to
> > > > send the fixes as reply to the individual problematic patches. (ins=
tead
> > > > of fixes to commit ids that are not upstream)
> > > >=20
> > > > [yes, I'll do more review soon :) ]
> > >=20
> > > I appreciate the feedback, it's much better than yelling into the voi=
d.
> > > I have one more fix in the works - for __vma_adjust() of all function=
s
> > > so that'll be impossible to follow anyways :)  I'll work on a v11 to
> > > include that last one.
> >=20
> > Please do also post the incremental for that "one more fix" once it's
> > ready: I have been keeping up with what you've been posting so far,
> > folding them into my debugging here, and believe we have made some but
> > still not enough progress on the bugs I hit.  Folding in one more fix
> > will be easy for me, advancing to v11 of a 69-part patchset will be...
> > dispiriting.
>=20
>=20
> Okay, thanks.  I don't think it will fix your outstanding issues but it
> is necessary to fix case 6 of vma_merge() on memory allocation failure
> as reported by syzbot.

Hugh,

Please find attached the last outstanding fix for this series.  It
covers a rare failure scenario that one of the build bots reported.
Ironically, it changes __vma_adjust() more than the rest of the series,
but leaves the locking in the existing order.

Thanks,
Liam


--_002_20220715195301r7ozt6ph2scti7vzrevolver_
Content-Type: text/x-diff;
	name="0001-mm-mmap-Fix-__vma_adjust-issue-on-memory-failure.patch"
Content-Description: 
 0001-mm-mmap-Fix-__vma_adjust-issue-on-memory-failure.patch
Content-Disposition: attachment;
	filename="0001-mm-mmap-Fix-__vma_adjust-issue-on-memory-failure.patch";
	size=3449; creation-date="Fri, 15 Jul 2022 19:53:10 GMT";
	modification-date="Fri, 15 Jul 2022 19:53:10 GMT"
Content-ID: <2C031AE421734C4AB603D3AEA9807D3C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAwODE5OTVjZjEzNDc0MDZjYjhiZThjN2NlMTFmYmIyNTYxNThjODNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCAxMyBKdWwgMjAyMiAxMDoxMzozNCAtMDQwMA0KU3ViamVjdDog
W1BBVENIIDEvMV0gbW0vbW1hcDogRml4IF9fdm1hX2FkanVzdCgpIGlzc3VlIG9uIG1lbW9yeSBm
YWlsdXJlDQoNCkluIGNhc2UgNiBvZiB2bWFfbWVyZ2UsIHR3byBWTUFzIHdpbGwgYmUgZnJlZWQs
IGJ1dCB3aGVuIGFsbG9jYXRpb24NCmZhaWxzIGFmdGVyIHRoZSBmaXJzdCBfX3ZtYV9hZGp1c3Qo
KSBjb21wbGV0ZXMgYW5kIGp1bXBzIGJhY2sgdG8gdGhlDQoiYWdhaW4iIGxhYmVsLCB0aGVuIHRo
ZSBzZWNvbmQgVk1BIGlzIG5vdCBtZXJnZWQuICBVcG9uIHJldHVybmluZyBmcm9tDQp0aGUgX192
bWFfYWRqdXN0KCkgY2FsbCB3aXRoIGFuIGVycm9yIGNvZGUsIHRoZSBjYWxsaW5nIHByb2Nlc3Mg
YXNzdW1lcw0KdGhlIGZpcnN0IFZNQSBpcyBzdGlsbCB2YWxpZCwgYnV0IGl0IGhhcyBiZWVuIGZy
ZWVkLg0KDQpSZXBvcnRlZC1ieTogc3l6Ym90KzY4NzcxYzBlNzRmN2JiNzgwNGU1QHN5emthbGxl
ci5hcHBzcG90bWFpbC5jb20NCkZpeGVzOiBkM2NjZDE3ZTdjOTYgKCJtbTogc3RhcnQgdHJhY2tp
bmcgVk1BcyB3aXRoIG1hcGxlIHRyZWUiKQ0KU2lnbmVkLW9mZi1ieTogTGlhbSBSLiBIb3dsZXR0
IDxMaWFtLkhvd2xldHRAb3JhY2xlLmNvbT4NCi0tLQ0KIG1tL21tYXAuYyB8IDQyICsrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL21tL21tYXAuYyBi
L21tL21tYXAuYw0KaW5kZXggZjI1ZjUzZDc2MDBkLi41ZWQwNjg3MGEzZjMgMTAwNjQ0DQotLS0g
YS9tbS9tbWFwLmMNCisrKyBiL21tL21tYXAuYw0KQEAgLTcxMyw4ICs3MTMsNiBAQCBpbnQgX192
bWFfYWRqdXN0KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIHN0YXJ0
LA0KIAkJCQluZXh0X25leHQgPSBmaW5kX3ZtYShtbSwgbmV4dC0+dm1fZW5kKTsNCiAJCQkJVk1f
V0FSTl9PTihyZW1vdmVfbmV4dCA9PSAyICYmDQogCQkJCQkgICBlbmQgIT0gbmV4dF9uZXh0LT52
bV9lbmQpOw0KLQkJCQkvKiB0cmltIGVuZCB0byBuZXh0LCBmb3IgY2FzZSA2IGZpcnN0IHBhc3Mg
Ki8NCi0JCQkJZW5kID0gbmV4dC0+dm1fZW5kOw0KIAkJCX0NCiANCiAJCQlleHBvcnRlciA9IG5l
eHQ7DQpAQCAtNzYyLDcgKzc2MCw3IEBAIGludCBfX3ZtYV9hZGp1c3Qoc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgc3RhcnQsDQogCQkJCXJldHVybiBlcnJvcjsNCiAJ
CX0NCiAJfQ0KLWFnYWluOg0KKw0KIAl2bWFfYWRqdXN0X3RyYW5zX2h1Z2Uob3JpZ192bWEsIHN0
YXJ0LCBlbmQsIGFkanVzdF9uZXh0KTsNCiANCiAJaWYgKG1hc19wcmVhbGxvY2F0ZSgmbWFzLCB2
bWEsIEdGUF9LRVJORUwpKSB7DQpAQCAtODUzLDYgKzg1MSw5IEBAIGludCBfX3ZtYV9hZGp1c3Qo
c3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgc3RhcnQsDQogDQogCWlm
IChyZW1vdmVfbmV4dCAmJiBmaWxlKSB7DQogCQlfX3JlbW92ZV9zaGFyZWRfdm1fc3RydWN0KG5l
eHQsIGZpbGUsIG1hcHBpbmcpOw0KKwkJaWYgKHJlbW92ZV9uZXh0ID09IDIpDQorCQkJX19yZW1v
dmVfc2hhcmVkX3ZtX3N0cnVjdChuZXh0X25leHQsIGZpbGUsIG1hcHBpbmcpOw0KKw0KIAl9IGVs
c2UgaWYgKGluc2VydCkgew0KIAkJLyoNCiAJCSAqIHNwbGl0X3ZtYSBoYXMgc3BsaXQgaW5zZXJ0
IGZyb20gdm1hLCBhbmQgbmVlZHMNCkBAIC04ODAsNDcgKzg4MSwyNCBAQCBpbnQgX192bWFfYWRq
dXN0KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KIAl9
DQogDQogCWlmIChyZW1vdmVfbmV4dCkgew0KK2FnYWluOg0KIAkJaWYgKGZpbGUpIHsNCiAJCQl1
cHJvYmVfbXVubWFwKG5leHQsIG5leHQtPnZtX3N0YXJ0LCBuZXh0LT52bV9lbmQpOw0KIAkJCWZw
dXQoZmlsZSk7DQogCQl9DQogCQlpZiAobmV4dC0+YW5vbl92bWEpDQogCQkJYW5vbl92bWFfbWVy
Z2Uodm1hLCBuZXh0KTsNCisNCiAJCW1tLT5tYXBfY291bnQtLTsNCiAJCW1wb2xfcHV0KHZtYV9w
b2xpY3kobmV4dCkpOw0KLQkJQlVHX09OKHZtYS0+dm1fZW5kIDwgbmV4dC0+dm1fZW5kKTsNCisJ
CWlmIChyZW1vdmVfbmV4dCAhPSAyKQ0KKwkJCUJVR19PTih2bWEtPnZtX2VuZCA8IG5leHQtPnZt
X2VuZCk7DQogCQl2bV9hcmVhX2ZyZWUobmV4dCk7DQogDQotCQkvKg0KLQkJICogSW4gbXByb3Rl
Y3QncyBjYXNlIDYgKHNlZSBjb21tZW50cyBvbiB2bWFfbWVyZ2UpLA0KLQkJICogd2UgbXVzdCBy
ZW1vdmUgYW5vdGhlciBuZXh0IHRvby4gSXQgd291bGQgY2x1dHRlcg0KLQkJICogdXAgdGhlIGNv
ZGUgdG9vIG11Y2ggdG8gZG8gYm90aCBpbiBvbmUgZ28uDQotCQkgKi8NCi0JCWlmIChyZW1vdmVf
bmV4dCAhPSAzKSB7DQotCQkJLyoNCi0JCQkgKiBJZiAibmV4dCIgd2FzIHJlbW92ZWQgYW5kIHZt
YS0+dm1fZW5kIHdhcw0KLQkJCSAqIGV4cGFuZGVkICh1cCkgb3ZlciBpdCwgaW4gdHVybg0KLQkJ
CSAqICJuZXh0LT5wcmV2LT52bV9lbmQiIGNoYW5nZWQgYW5kIHRoZQ0KLQkJCSAqICJ2bWEtPm5l
eHQiIGdhcCBtdXN0IGJlIHVwZGF0ZWQuDQotCQkJICovDQotCQkJbmV4dCA9IG5leHRfbmV4dDsN
Ci0JCX0gZWxzZSB7DQotCQkJLyoNCi0JCQkgKiBGb3IgdGhlIHNjb3BlIG9mIHRoZSBjb21tZW50
ICJuZXh0IiBhbmQNCi0JCQkgKiAidm1hIiBjb25zaWRlcmVkIHByZS1zd2FwKCk6IGlmICJ2bWEi
IHdhcw0KLQkJCSAqIHJlbW92ZWQsIG5leHQtPnZtX3N0YXJ0IHdhcyBleHBhbmRlZCAoZG93bikN
Ci0JCQkgKiBvdmVyIGl0IGFuZCB0aGUgIm5leHQiIGdhcCBtdXN0IGJlIHVwZGF0ZWQuDQotCQkJ
ICogQmVjYXVzZSBvZiB0aGUgc3dhcCgpIHRoZSBwb3N0LXN3YXAoKSAidm1hIg0KLQkJCSAqIGFj
dHVhbGx5IHBvaW50cyB0byBwcmUtc3dhcCgpICJuZXh0Ig0KLQkJCSAqIChwb3N0LXN3YXAoKSAi
bmV4dCIgYXMgb3Bwb3NlZCBpcyBub3cgYQ0KLQkJCSAqIGRhbmdsaW5nIHBvaW50ZXIpLg0KLQkJ
CSAqLw0KLQkJCW5leHQgPSB2bWE7DQotCQl9DQogCQlpZiAocmVtb3ZlX25leHQgPT0gMikgew0K
LQkJCW1hc19yZXNldCgmbWFzKTsNCisJCQkvKiBDYXNlIDYgKHNlZSB2bWFfbWVyZ2UgY29tbWVu
dHMpLiAgQ2xlYW4gdXAgbmV4dF9uZXh0LiAqLw0KIAkJCXJlbW92ZV9uZXh0ID0gMTsNCi0JCQll
bmQgPSBuZXh0LT52bV9lbmQ7DQorCQkJbmV4dCA9IG5leHRfbmV4dDsNCiAJCQlnb3RvIGFnYWlu
Ow0KIAkJfQ0KIAl9DQotLSANCjIuMzUuMQ0KDQo=

--_002_20220715195301r7ozt6ph2scti7vzrevolver_--
