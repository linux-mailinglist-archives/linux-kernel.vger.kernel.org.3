Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4789573C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiGMRug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiGMRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:50:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5EA2D1C0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:50:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DFS37J006838;
        Wed, 13 Jul 2022 17:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sQKrh4Ui27rZXYBesaaBvaG2FuMq6mFYY/5rZFJwOH0=;
 b=gcqhDCyxjvU939qn+roTpauNlVWez3umjm5WfvVGLmiZrjw1+oIZ2zmCBg8W8S7KiU4I
 +TyytA6+BxdhxlbAfqGZNM0kLnbivIoY3q25A4vGnSGLtCyx2vbBIYsketVMvuRZwwH3
 sHp40PF/F5hhWvhQhX5kKc0rxH/4ZYk6ZPDPhhdJiqEkoZ0pQ2OIBcBIb73llf/G5nux
 C1e1r1jbOgpcVZYJ7W/eKIDiGODD9y6QlFhe7bKwissZNLEFqR7u/WURCVia2VTxMuJl
 0iRiyiKBa0INk0qToB02RYKGs3YbperDBk87XYtKgSkl4P7flxRxiZZKY+rwbT6KVdip yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrk015-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 17:50:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DHeeDv012120;
        Wed, 13 Jul 2022 17:50:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7044m1jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 17:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhLzYsMZvNeIoSqzCV6gMVMgHt1JVSp6IK3WgNErw7YAjl0f8MnIJuVy9OstOmY/kPxM4c32h5LAXfPQl+v5R8TkxcSKzEPSrkSVG3nkvJbO5dE3twr7XBj9QZiaES7hziWWhxg6RWHG0/dvIUIfUYg/xaJ7RjoKWbRWZKesyL+Lqi2jHjoMjyGXysDMzKHT/vVfrmtwRDoETsC1drcr1ieSaLWLQ9MteiIF7AzQYY9QSLUXYgukuRDs8ewd6oMNIkHl4pPe8nFx6fD352Q9+EOIqsF543ZSFd1P2nCshwpj6Yzfhj6+7O2zLqqR3hCw7uVRgxsNNL5EvwXjWMZixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQKrh4Ui27rZXYBesaaBvaG2FuMq6mFYY/5rZFJwOH0=;
 b=IocncxiAGwq9iZHjOco20Nz4F8LNUpFIdpsgh2UjPnO/b9FnxLYOdJac1HnkLvEAM6KcVqM7t4hBUPZ0GPMeyJerOujV1K5k1Sb3R53NzfpzIGPrE7FH34TQA/k3vOJB4lWmgK+mxFLjRMO0mBLFmrIRp8QfX/Giu+hTWpZveomeFZTaf9IVGksprg4xsmxbkhCY/+afL+IIqnoNvxvtXFSTDDfaPJbIV7rwYlm7mx1fZVBFj9KeZYGWXTu0kEWWyt3cTtTKImmP5YFfAyq/942FgQfhgDCA7APTNzx2R55BJ9InN6rq8zaoLhG3Gf/3es9ObUAG5gQmEtCFJuwImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQKrh4Ui27rZXYBesaaBvaG2FuMq6mFYY/5rZFJwOH0=;
 b=RhpHiajNghUkPEHDhwdrDP+d3hAw3SuAdbvtQx/UPc8kDxDgfjN5uosf1Sth5lUPq1k6yh1njskKLDeP1UclY+A2UevlWiPk6VnIz7JZ/zIRtk/1CDnzB0LHLPdAF29rTO5Sh2g1nUXO8rz5wOZJ7484aEP4YnxxvLIgkdAPpXo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4314.namprd10.prod.outlook.com (2603:10b6:5:216::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 17:50:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 17:50:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     David Hildenbrand <david@redhat.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Thread-Topic: [PATCH] maple_tree: Fix sparse reported issues
Thread-Index: AQHYlfsoLhkzbf9CQkS2b2OLBBRjJa17+qSAgABSigCAACjrgIAAH/GA
Date:   Wed, 13 Jul 2022 17:50:20 +0000
Message-ID: <20220713175013.aoemaelds45aavc4@revolver>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
 <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com>
 <20220713132926.3sl7gs67dyjj7kit@revolver>
 <44a478e8-2ccc-e82-bd5a-172778c01529@google.com>
In-Reply-To: <44a478e8-2ccc-e82-bd5a-172778c01529@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ebc731e-e7ac-4d25-31c7-08da64f827b8
x-ms-traffictypediagnostic: DM6PR10MB4314:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WwcgwaimbawiSnRD+7n27revIVYGUn9VcJUWEmb0dsjn1mHxw5Uhig+lo17LP1QlszqS3G8W/PSAf1MlvrQIT30AWwCCZS0wnMDxM+GDWjSZbMnf+2sDtPuPH0SR078dBVYDcCI/A3LMMWa+N/Bs5+XyyF2uwv7+HhyJgsc0git1XprNoOVgvz5JrRSeJPharXKngVlk3u4Tyr/6KspoWd3NJswMVViiNuRzB/KU/KorBCbeG+stOzb9OdywUuLsr0lCDHfPV1R+NrmJVFetEP1N51AotgjoYiXpGTKyhvkyuGaTpVUiWxxDNz2NVQEOJ/wa1FW4mfr/dwIo6GPBUZDIz3C8dWZyhOrTi7TEew/K4airOlycdtsEDbyqNQaBL0fuxBEKqtMe3O5xzGRjZkcN2aCqj3815GBFBldA/SR330lRixdTKH6sOnv2Ez6dF5QUbRRJwsAt0AthOOsehKOG5wl5sXwggJvYX1iOK9HBY5YqbeGo4gLdnJlDvIa6tWcWHIbVJOkz8nBq69mRMjO1nfSWWLC6UjPR6NC2aQE6+4BG6ZftW1DIghpgorQRGShnda6Qd9/a8lSMRCxPNGKJog2E239rl9VYLDyHAQTKCt8QhugCv87ATAhTHeDExQDZdDxegp535cEpU1z/UHlDb3Un/8Y21/RVKkBOpjCoGI+jePXonjay8I3r5Jc/o1e1lyWaiNESXaPJ76xnjfm2OhCuATy0Nkld22l67vIeoOujzdKO45MpS5whmANvo90x9ILgjbAYpmdBHMNgE7dAD7RtZ+5tEd0zOR2hJBopkqVZ9IOmaX67vYKTYNOz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(396003)(136003)(39860400002)(366004)(26005)(9686003)(6506007)(8676002)(122000001)(478600001)(41300700001)(6512007)(8936002)(2906002)(53546011)(5660300002)(86362001)(44832011)(186003)(83380400001)(33716001)(4326008)(1076003)(38100700002)(38070700005)(6916009)(66556008)(66446008)(71200400001)(66946007)(66476007)(316002)(54906003)(91956017)(76116006)(6486002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W/pxoJjCOAVAxW3tiS8Heyoxn6aR0p9WYF0Ckq81drjHNmb2T6A4PisQqTNS?=
 =?us-ascii?Q?TYgBz4YUrEmsWXQOfN5N1QgTVWEixj7/mTbKUmycBJWwxD9NJLndVZaCbxWp?=
 =?us-ascii?Q?ip4jrCMFLRfWH5dP618+88tQlX0IGt0nYb1RHcTyTz9pXJya4u6ZXNSB0pmI?=
 =?us-ascii?Q?ENYZazKVOiC4MtfJWoaML4ZHDIdFGK9IuGXB0+W6GWPWBIFkTVsr0IEoM9BR?=
 =?us-ascii?Q?DsaNxP8/opai3u70L2QBS4fyaLvbbxAG+Rm1oVadbeM1aM6r0GFObwpV8lf0?=
 =?us-ascii?Q?SSeXIz59VVl16yiMUh73cZcF9xuVLotj5R6ptleyBADaPkGWnOxzoDa91XHg?=
 =?us-ascii?Q?yp7vLuk6O0dVniL44SI33ewE0xdjnQAgrvFC2I+SiologSGeJyhdkyb2XK9q?=
 =?us-ascii?Q?nVraGvQ7qiWNo+5/xgMb8oY/4ytuoABogULSMrlTFuDgOm1ngOZA6n3gkpux?=
 =?us-ascii?Q?0xKCAegiYNhMfFJ7Q0n+mwvWyaVWc+CiZyiegnpA+ENvl/8Zm1B9wkV8jaFG?=
 =?us-ascii?Q?95epsejwF0XjiDzW1VG6VzU4Lt1/wyi2hNlemSMEf4aHEjY06LwROqvRY60v?=
 =?us-ascii?Q?uiKbfHnvnBcrXbE+OmDUj8iqeC21iJj83MKbbk2p5a6fWv2PV6eal15/lOoa?=
 =?us-ascii?Q?GIBe417u1EZLajP/T5xgkcsBPmok+qU+KLZlqGFnDKItSQdfpp+dqhxbR8IA?=
 =?us-ascii?Q?XrZqZh6/FHLUntkiy43U3OCC5xxjplNC7NpJpAqyeFQcoLDePLyK846ksG3c?=
 =?us-ascii?Q?Zc/qVa/J9sLwLvnZHF7OoiSseslKhmcsFcOm6XKTg5NsyT94olcUFnBMRwDx?=
 =?us-ascii?Q?6PUcB+g4c1qT2WpHQ30YayCPTDijItH7ZWRuqu8N0sU5kTh8GmE71Up90DMP?=
 =?us-ascii?Q?PyL/Dp+qevrJbDLh+HFYDzbtv0JjE+LHKXkVXkFDMrpX3rtjASFwKmYsvgVm?=
 =?us-ascii?Q?xWt4Sns5f+n84Gr/BEe72SDgRM0PDEePflPitr5z6lHnxSqWGQU9NBwAvnyS?=
 =?us-ascii?Q?xJy5hzeIKhVzlkUaKW6KygjY/1rP5Z3gG09oBvjq7W0SvTAR/txw5uVsH9hI?=
 =?us-ascii?Q?/eq5NyIb9ORdzgG3iE30VjZ6ZSmYiWYLTjwNgJ8mrlCdrK2OLJ8RYc4k/9kD?=
 =?us-ascii?Q?etelkf8YRzHvrfK0Vmh1tyWTJKKnCMefKu3MzCRaOnQFS/qdjqiG4QG/mRcD?=
 =?us-ascii?Q?rzi4IEnmbbphq/8KV7TMIGs16F0z8mabJkGHp/pORoLYHFHmaexhmVUeMtW8?=
 =?us-ascii?Q?OL//vBanwvOllkTrtgCiQD0PZDnKKGCiE9Evdji0K5klDQfWPACxy12Ujb1x?=
 =?us-ascii?Q?Eb9uQYJBl5sgA/vEOc+A2nup/YLUTUi/B5DP59+Urii2/qihgLYVEdtzFFKx?=
 =?us-ascii?Q?ZaOfalB/WiWN5vlqJfcXi9UW6yQWXgehaIkFffBwlu/zwn9B0mavNzbTAtpz?=
 =?us-ascii?Q?AiPlONU8d93YFGdUPeQF1O5d2dtAZTCdwbZ/Ee/Xzes4ARWH0A5Hp1ihn9P/?=
 =?us-ascii?Q?/ZrpgCUDNmJmpOU/ya7L3rpeUzRjv8CCkJlNf7O01DanjmD6qJGCOq+lnIpo?=
 =?us-ascii?Q?Z00NNc+rw4XD0CIJ2XjiLtDy1Qnp0vmPN2jFSuIgw3ktj1zuTmWNYDCR/XQv?=
 =?us-ascii?Q?6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC422E973405A543B8E54A391FD207DC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebc731e-e7ac-4d25-31c7-08da64f827b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 17:50:20.7083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbjXXkWiM5QobLDlAtYDLQgACe8jh7zFKTEvlTvw4we8QOnvVgyzqUVlHsTBx3bpvJaVNxXyJRVmL70UMZAx5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4314
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_07:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130073
X-Proofpoint-GUID: RbdkW9MMAE_pUrsMDdupc1aa5Fzva_v-
X-Proofpoint-ORIG-GUID: RbdkW9MMAE_pUrsMDdupc1aa5Fzva_v-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [220713 11:56]:
> On Wed, 13 Jul 2022, Liam Howlett wrote:
> > * David Hildenbrand <david@redhat.com> [220713 04:34]:
> > > On 12.07.22 16:24, Liam Howlett wrote:
> > > > When building with C=3D1, the maple tree had some rcu type mismatch=
 &
> > > > locking mismatches in the destroy functions.  There were cosmetic o=
nly
> > > > since this happens after the nodes are removed from the tree.
> > > >=20
> > > > Fixes: f8acc5e9581e (Maple Tree: add new data structure)
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > >=20
> > > Sorry to say, but the fixes become hard to follow (what/where/why). :=
)
> > >=20
> > > I guess it's time for a new series soon. Eventually it makes sense to
> > > send the fixes as reply to the individual problematic patches. (inste=
ad
> > > of fixes to commit ids that are not upstream)
> > >=20
> > > [yes, I'll do more review soon :) ]
> >=20
> > I appreciate the feedback, it's much better than yelling into the void.
> > I have one more fix in the works - for __vma_adjust() of all functions
> > so that'll be impossible to follow anyways :)  I'll work on a v11 to
> > include that last one.
>=20
> Please do also post the incremental for that "one more fix" once it's
> ready: I have been keeping up with what you've been posting so far,
> folding them into my debugging here, and believe we have made some but
> still not enough progress on the bugs I hit.  Folding in one more fix
> will be easy for me, advancing to v11 of a 69-part patchset will be...
> dispiriting.


Okay, thanks.  I don't think it will fix your outstanding issues but it
is necessary to fix case 6 of vma_merge() on memory allocation failure
as reported by syzbot.
