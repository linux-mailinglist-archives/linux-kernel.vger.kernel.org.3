Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE150898D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378942AbiDTNrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379025AbiDTNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:47:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B89433BB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:44:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KC9jZe009567;
        Wed, 20 Apr 2022 13:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=F7nzYoS3PF+I3tHMS8l/Z70ewpwUBHezyV9o6Ks+iTo=;
 b=BDurdpgzL4K1UkouKwxV+0jhVHgYur170x+LXlrhX2BRbZoit0ytyjOIMrzo+fmUBUkr
 WpsNZCGKUWSvwWEkKLuD4P/Zr0tpG6PY+1QbnQTn0btP15a5gFa5+ZDsMiU/SBw3hapu
 Booe5jvANHLsV7d+wO5VQniJ0EdiRewy/eFUFLAAl2VUFNhfFSqGAx9qfOrV1R09bWwc
 aeyDQu8Ukm1GkFwaTfeC/3J9NiTK7Fbl+X8khhaSdiIzjr84sb3JKrhWbNWDZ6OQrD6j
 2OAM2Nr8SDOkq+RBctg6peQxg17oGSYCuu07FBZXR1c3pvtMpdnvLstBrCLh5ui7icbn GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndth4en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 13:43:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KDein4026982;
        Wed, 20 Apr 2022 13:43:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm870b8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 13:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buQzFM1rraf8KhESFzKrnlM4BzDFNuISbg/m5GVHt+DRiD8OReXvD4sDTCTSKWVrBdxjF/xlkYb7XZa3NDxoG61AImbyUr7IPta88qWwwDq8s83azWgH9Y5KSYHmBeo61bCDXLov33/bg/q/M90oYh8LYqiUXmwpLEvfDRAcCzzxNbaDzR0/ElYfxg5IsF8zzJRAx/nnYV5gbNU5X9BqI/MZyEyYhywLbLCU7cg9yLRg9e6XG6J4njuwlUzfG46gpiEEai644qxLt2FdgLhZI5oNzeR+wvcjgobpzL2S+WXkWKfC6qgyQaZ+HZspSb4RDLi9bLAXiW1dOXprUcuT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7nzYoS3PF+I3tHMS8l/Z70ewpwUBHezyV9o6Ks+iTo=;
 b=B3rIsiMQk4N2UtfERFCynmvhi2sq32TnaW3AfNqvZ0r5EBps1IrSZc6inB3lK2VAz4+whDtfAuVNv2uJiBdwyG3Y34pAf/kimTlZU2QhG8DkgFCZ7c2I3/WlbVEpttE0l2mKWsaH4rpwgwEmWZNI8izl2sa6TdSJSZEwyMbZT9dlWxipwFSW8ajVTWa28fysKedJs02JJVpHyIcgIBA8Z2+oYXqAOFji4Fv94N03OQNzg7UlAURUZ+Oi6lhiQ/FoM51qkwnLi/qBg6XwWR45tVF6RKDbJ0ROHjZOCtFe1NmnGQNDu1XojRS+DqGf1UEMek8zHjwrfGx9MdwnoWTPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7nzYoS3PF+I3tHMS8l/Z70ewpwUBHezyV9o6Ks+iTo=;
 b=YzYuqrVIOnULAK6p/Lkl0qW0V+UwJTrTy8YbvTEpg8Kt7MR2jD4DIq/+DpL8PyInjn1CqRcqUe5hd31GrokOpyFHTHEHWzPa21KPN/vNNRHbSsFj/B1lQ07u1AIVCQiJdGCutC9qh7rN0pMwplu+DBjJpOq+KtfDuUwAa2MGyZc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5417.namprd10.prod.outlook.com (2603:10b6:510:e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 13:43:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 13:43:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Index: AQHYSDE59w1vuFTbRUqY9YC4imYEkqzvB5KAgAB3GACAADJWgIAABQ6AgAAimYCAAMbngIABK32AgAA0VgCAALsBgIAARfaAgAR5x4CAAGa4AIAAFiQAgAABYoCAAPCFAA==
Date:   Wed, 20 Apr 2022 13:43:47 +0000
Message-ID: <20220420134336.bny7wza3ez2ldjsd@revolver>
References: <20220414121911.8bb89fc3681b13af1566d79c@linux-foundation.org>
 <YlkaiUopM5HKWEdX@google.com> <20220416010259.4gbz5hgvm2lgr3sj@revolver>
 <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com>
 <20220416151923.ig5zavuptjsufm3d@revolver>
 <CAOUHufZewjQyMy1pHKxRkY82J5STPbUSJor7Q2aJgrkpZvU6bw@mail.gmail.com>
 <20220419155055.qf52xpcftqb3r5nj@revolver>
 <CAOUHufbX_aq+aHf-EVKFLN_jw6hXJ5vtKpG0jskD6uXVKB406w@mail.gmail.com>
 <20220419231748.omnhkl43vl5ep2j5@revolver>
 <CAOUHufaR3Pbv_PgGpzfmzzCHLLwBkHT8G-RcDfe1bo0zESekPw@mail.gmail.com>
In-Reply-To: <CAOUHufaR3Pbv_PgGpzfmzzCHLLwBkHT8G-RcDfe1bo0zESekPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88dd6f3f-5c29-47e8-6b14-08da22d3cba9
x-ms-traffictypediagnostic: PH0PR10MB5417:EE_
x-microsoft-antispam-prvs: <PH0PR10MB54174FE0FF3E0241234D6E09FDF59@PH0PR10MB5417.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yB1CJuhrXt/eV8buzF+FCigtYu+mpArOidvk3eoCn6ezSOU/WhWqTD/bbQtAFhkvNorzbg1rDEVm5qzUiJ7aiQ7HrcoT2DmR7EilCbMfyUZAsAaQOiIKXnuglDP8pRrgdaKKI8YCplBdG+3ZffsW4G5X26r4YuFlPf6GoRUnvFAlglsO5BAz2MdVj21CtKwvxs2vBeCfjpAECiSyUdWIXJjhlj1Y+5K6732M+8uw+E7gWmBajo/SmEUrSWB4KgrT77xAdgaSH9cz/JhlKBmxX0CWXJjMN/d6QG342qErUN5nCad4ONBIGT/wyVNw65MT/5me5oujfXFPwBT7cpGGguSfg4FBK7YpXyn7TxiBnu0iEjsRTRmjaPAoZznTFZxYPeUCds6W0scPyk+DuNFH9SC9816BJfxq13JBT1aR9yiAr0k7X4N30mxFS1cjwfOXH+AenVjZWXXro02MJ/1ApBKNVhy8QaxtJftkKbvIaAph11i4Okzh34BmsP6MHQzSh8+/SDcx3oEXcrhoxnvV6yL5pC4ckTkxvWLqpT6ZnvySzO0Vj+ZmkvomD0A9Gk/0vzZ/g/vlKSm6jrcOOlXjAvOPyTmeKOFyVqEsn/Bkmpy7O3K7SF1qs+K1wkHX8uWWjmEHAtTxJzTVYaBp3bY9jpmqfDe1OQM2H6RMLNygc6V9/DxfilU9/QGMcQ3s4ipSZSX5XVFC0yTFEpAecWLCvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(44832011)(53546011)(26005)(76116006)(64756008)(71200400001)(66556008)(99936003)(91956017)(33716001)(66476007)(66446008)(8676002)(6512007)(9686003)(66946007)(2906002)(6506007)(5660300002)(186003)(1076003)(4326008)(8936002)(508600001)(38070700005)(6486002)(38100700002)(316002)(6916009)(122000001)(54906003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XPlsLlwKph5clPRBn+0hmXhYVgNW5TLOq83dAQoM75Sc2mV2cJ+rK80mKUWc?=
 =?us-ascii?Q?JG+MSyK6zOEy0m/ypaJUDpG1wIFEwvNnwFHUto8zmmitBiwCc4NQ4NXG4b7d?=
 =?us-ascii?Q?PzkZI/SknRk+KY38UGIZze9203stxLNgFLGwCKK55COHTy7j+27QS5C9qP00?=
 =?us-ascii?Q?PIl04bSNwN4aAzMlsSRfxM4foIp6osIiVyI8+No6HybM1/E5pNl2gV/VqPAp?=
 =?us-ascii?Q?GLUNM3ZpcK09ECybcQleTXt241RrsByG9XkuY8Hu/jFKHAwc1gn+OpdtxZEm?=
 =?us-ascii?Q?Er24wL3AK/HySTN+eiDpmTQjLnPCxlpTR7+7uXpxsbWPhmtLSJIrX7kDm+l3?=
 =?us-ascii?Q?8khxF1oZ/0oIHVWpo0HDAGxSYCYJDBRC6ywuYPv3btx6r1DUjv1EO+DyacBk?=
 =?us-ascii?Q?I8668Jvx38fAN6IaUMc0A3lt1QSFbmAcgoR6mOP4hhH2Iieho6S4iQEkWZA9?=
 =?us-ascii?Q?BBMuI/gjmFgaSmLPVTUbmlAxXtlbn+jGfHh6UPJOQ74baBnOlEUO3h1e62UE?=
 =?us-ascii?Q?k63eqZzFAY0U2/nb42CupGpYAECpWSaYK98XkK7KGDQO8WaBkYy+0YY7yeSp?=
 =?us-ascii?Q?QImkhM+cHOW35ly3XtfkQM6AZvGilxS9OqPwYGFmiA+Bo/szOljKSd1Ww+CG?=
 =?us-ascii?Q?Y7GYElHz8dR8huD5SYBBP2Oi8hvuxhvP8nzoLPZdxhamrDJduRDg6NkVzcf+?=
 =?us-ascii?Q?fzpel0yTwUNWglY5SBifKcM5tRkMjCreOljWnxht6bMjHn4SRoPCU7TwMwrX?=
 =?us-ascii?Q?JM3WZjqvgbs5Uobr40skfygdZLwF1cSE6H7Zpc1AtOp4rYK3num7ezk3KSKC?=
 =?us-ascii?Q?dZAbHDLljgSDPGTChUxUXoKg/bvfsOKVpo/L78TDTPuutl/w0gmF3Eos0i/o?=
 =?us-ascii?Q?a616/SgXXAVoVwBC5+umgfON+9s3PSDZ3dDp0UTlh8QO53mdoGh+hceqP9uX?=
 =?us-ascii?Q?ubkvyVSmFdeiIbw6j2DZhaWIfx7Bwq4hf4ka4YlST7Rex0NXjUa9p5mrryeo?=
 =?us-ascii?Q?WK7pNstLvqmyGbwO0iG9Vbe2pgOHlrj368G4BVWEf+uPcYLtbIafnmRCTuaG?=
 =?us-ascii?Q?vTePq2UwOlp29XKalNs0fLG8MgkixKV5sxGdMOvDZOmMefOnrvRtlOY27IZp?=
 =?us-ascii?Q?GDHvG1EgNXFrOCuWeOHuWyac3lZecEKmzB3JrMmiVoZ9WDI1vNvFOp4g13yD?=
 =?us-ascii?Q?vBf7vo2MOFO/wdJSv8mRdzUV2X7w/qX/FdWi7fAp1oGk928xtSaFW0/XMCm4?=
 =?us-ascii?Q?DZyqa1EJkO6UjoLtpurs4TNxQ9GUMtMnqCR/0qLpAqEXOi38MfG5s/5ELoHm?=
 =?us-ascii?Q?mpZm3HPhsywxfcmG0cWxdLHkLIgWYkbT1zoN1D3G59/yQtxNP0rZHxEvoUN2?=
 =?us-ascii?Q?ngvqp82lqsOFRQNIn1TRuEGHG7BtPmxFjWhI1TOe3lO6NdEvzip87zfMn4w/?=
 =?us-ascii?Q?bI2L7omxT1Watd55/gDiI0iM2Vru6Mg08IfU2rJtQG4ja7OBSvbBRIPtupB/?=
 =?us-ascii?Q?LCipHIxSZeTCa0IW7pIbFywnyL4Pi0lBwSyOEk2IWD8i62LkZyrzkHWGC7+z?=
 =?us-ascii?Q?DaeT6Ya28YC1pNAeNt4Sdi4UT2TnqbeFrr25lyvuA18+OVdUo2I+qt4RCQtB?=
 =?us-ascii?Q?Ctp1GDhDT1NregHRi61k1G2uF1Od8gOvNXhqm5oxvfIDdiTCVmKtFWuNb6x1?=
 =?us-ascii?Q?7iHyrt0jNOgOn/cCZKDY54iz2yn+Xigbr1tm+8kuOkwYeuHSU1sexLDKLDwn?=
 =?us-ascii?Q?dD41bcXVXxmCzSVWqcfrWDb/zMPIpvY=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220420134336bny7wza3ez2ldjsdrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dd6f3f-5c29-47e8-6b14-08da22d3cba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 13:43:47.6511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsYh8FK3az4WO4Ya7iEWxZF1Bs+624T/ibq1+JKH604N4b815wiyCg7H0FqgwiUaVmJTPobu09fnX2TBj72wQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5417
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_03:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200082
X-Proofpoint-ORIG-GUID: j_n2mXJbQ7xGyKs5j-xkXmktT2-wAuBy
X-Proofpoint-GUID: j_n2mXJbQ7xGyKs5j-xkXmktT2-wAuBy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220420134336bny7wza3ez2ldjsdrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17C3EA66E096B04FA5FCDA83D9D57E07@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Yu Zhao <yuzhao@google.com> [220419 19:23]:
> On Tue, Apr 19, 2022 at 5:18 PM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Yu Zhao <yuzhao@google.com> [220419 17:59]:
> > > On Tue, Apr 19, 2022 at 9:51 AM Liam Howlett <liam.howlett@oracle.com=
> wrote:
> > > >
> > > > * Yu Zhao <yuzhao@google.com> [220416 15:30]:
> > > > > On Sat, Apr 16, 2022 at 9:19 AM Liam Howlett <liam.howlett@oracle=
.com> wrote:
> > > > > >
> > > > >
> > > > > <snipped>
> > > > >
> > > > > > How did you hit this issue?  Just on boot?
> > > > >
> > > > > I was hoping this is known to you or you have something I can ver=
ify for you.
> > > >
> > > >
> > > > Thanks, yes.  I believe that both crashes are the same root cause. =
 The
> > > > cause is that I was not cleaning up after the kmem bulk allocation
> > > > failure on my side.  Please test with this patch.
> > >
> > > Thanks. I applied this patch and hit a LOCKDEP and then a BUG_ON:
> > >
> > >   lib/maple_tree.c:847 suspicious rcu_dereference_protected() usage!
> > >   Call Trace:
> > >    <TASK>
> > >    dump_stack_lvl+0x6c/0x9a
> > >    dump_stack+0x10/0x12
> > >    lockdep_rcu_suspicious+0x12c/0x140
> > >    __mt_destroy+0x96/0xd0
> > >    exit_mmap+0x2a0/0x360
> > >    __mmput+0x34/0x100
> > >    mmput+0x2f/0x40
> > >    free_bprm+0x64/0xe0
> > >    kernel_execve+0x129/0x330
> > >    call_usermodehelper_exec_async+0xd8/0x130
> > >    ? proc_cap_handler+0x210/0x210
> > >    ret_from_fork+0x1f/0x30
> > >    </TASK>
> >
> > Thanks - I'm not sure how this got through, but this should fix it.
> >
> > This should be added to 4236a642ad185 to avoid the LOCKDEP issue.
> >
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3163,9 +3163,9 @@ void exit_mmap(struct mm_struct *mm)
> >
> >         BUG_ON(count !=3D mm->map_count);
> >
> > -       mmap_write_unlock(mm);
> >         trace_exit_mmap(mm);
> >         __mt_destroy(&mm->mm_mt);
> > +       mmap_write_unlock(mm);
> >         vm_unacct_memory(nr_accounted);
> >  }
>=20
> Will try this.


Andrew,

Please add this fix to the commit 4236a642ad185 "mm: start tracking VMAs
with maple tree"

I've attached the patch for your convenience.

Thanks,
Liam

--_002_20220420134336bny7wza3ez2ldjsdrevolver_
Content-Type: text/x-diff;
	name="0001-mm-Fix-commit-mm-start-tracking-VMAs-with-maple-tree.patch"
Content-Description: 
 0001-mm-Fix-commit-mm-start-tracking-VMAs-with-maple-tree.patch
Content-Disposition: attachment;
	filename="0001-mm-Fix-commit-mm-start-tracking-VMAs-with-maple-tree.patch";
	size=861; creation-date="Wed, 20 Apr 2022 13:43:47 GMT";
	modification-date="Wed, 20 Apr 2022 13:43:47 GMT"
Content-ID: <4BEBCB208882854883D9EC2BF079812E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBlZTRiMWZjMjRmMzBjZmYyNTI1N2IyYTc3YjZmNDRhYWQxZGI2ZTE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCAyMCBBcHIgMjAyMiAwOTozNzo1MCAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBtbTogRml4IGNvbW1pdCAibW06IHN0YXJ0IHRyYWNraW5nIFZNQXMgd2l0aCBtYXBs
ZSB0cmVlIg0KDQpIb2xkIHRoZSBsb2NrIGZvciB0aGUgZGVzdHJ1Y3Rpb24gb2YgdGhlIG1hcGxl
IHRyZWUgdG8gYXZvaWQgbG9ja2RlcA0KaXNzdWVzIC0gYW5kIHBvdGVudGlhbGx5IHByb2Nlc3Nf
bXJlbGVhc2UuDQoNClNpZ25lZC1vZmYtYnk6IExpYW0gUi4gSG93bGV0dCA8TGlhbS5Ib3dsZXR0
QG9yYWNsZS5jb20+DQotLS0NCiBtbS9tbWFwLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9tbS9tbWFwLmMgYi9t
bS9tbWFwLmMNCmluZGV4IGYxNzJmM2FiYTkwZi4uZGJmZDM1NzZiNmQwIDEwMDY0NA0KLS0tIGEv
bW0vbW1hcC5jDQorKysgYi9tbS9tbWFwLmMNCkBAIC0zMTYzLDkgKzMxNjMsOSBAQCB2b2lkIGV4
aXRfbW1hcChzdHJ1Y3QgbW1fc3RydWN0ICptbSkNCiANCiAJQlVHX09OKGNvdW50ICE9IG1tLT5t
YXBfY291bnQpOw0KIA0KLQltbWFwX3dyaXRlX3VubG9jayhtbSk7DQogCXRyYWNlX2V4aXRfbW1h
cChtbSk7DQogCV9fbXRfZGVzdHJveSgmbW0tPm1tX210KTsNCisJbW1hcF93cml0ZV91bmxvY2so
bW0pOw0KIAl2bV91bmFjY3RfbWVtb3J5KG5yX2FjY291bnRlZCk7DQogfQ0KIA0KLS0gDQoyLjM0
LjENCg0K

--_002_20220420134336bny7wza3ez2ldjsdrevolver_--
