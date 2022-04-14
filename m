Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C7E5019DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245443AbiDNRTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbiDNRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:19:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0216A9D0F3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:15:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EG2Kcr028053;
        Thu, 14 Apr 2022 17:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xJt9c9Y6efQNCBkntazbbFvnsc1l1Ap4M5Htc2yRYv0=;
 b=sR4WNZDdfLzW06P/WWIdxDKnMb86SyTWMzLRDWHD2q0bEFn8E42905aWKXqYYraMqxxl
 AcpFYPSWL3sNXkmxqemhnpGbYrEByFXN34i7Hf2JitPuht2XiC6GLpH6jEU9jL7v2R7r
 v1Wc7GT6yWXLw31W9IFNPOci9DQg014kEAl46htbxnOmKrXZ4sgnLXJylVcIu/2+xgbv
 p2hECQwdGeoCfovOe/rGSZe7YIF2ehxttTkmFXUklO1vQYy4nkTc3jvT89MAdZpnbtgj
 NVeyKsL3VtVFgCt51w+sDwLlLVW1yYHD0dkkG8io4bEMyOyyyU2f68g/ULVVJGEPK6kf CQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a4y9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EHBP8B016057;
        Thu, 14 Apr 2022 17:15:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k509xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLCaRWt99UfQOQTiDugax/Lxhu1UxpZTPgb9pyFHCVbd/8zhcrqdKprh23W+/tc0AA2ysCmLVlbdl8JY4TB74/L6h+wWHgrf56jIwkAvnYqq0P0GSH37VeEo7XM/8mhRhR9HzvLAedwLplnV4+khnL2PcDLKBg1OXfm2n4fUqseOCdOwMK25rVl+PvTCsBckE6QWJAecghA4zIXmEK5vq9ZYpcUXKylq9wCQaxc+ToTiy0Rn/0C9OEgJabRjBydcFhx9qPMokTjlgtzKsAbq413xc0d9Yleh1BgAZ/mmd0inRu1s9Xcf6s1SZIo281lIhS8D9Pk+ft1AZ2bQRRKW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJt9c9Y6efQNCBkntazbbFvnsc1l1Ap4M5Htc2yRYv0=;
 b=lxq3+oNQ7HbJ66tWom9cnsL2+k/NwGmuXHvoRFgaqDNdjbQovtiVgQhtkfl+4w1GtpPHjs9hL6cHq3NjzUGcpUDb5M7Y7MHrEyuQX5W5UH6iuKvA1ger4QOXHMfS0zdhxVuI/Q6wFuzA4mwmSw9sHh+5YMggFIbyOiAUJdT3TLdzxaT7/Yv3gN65O01qkLxopTC72dIjbHuk/6ZPgPZIxtc875MK4uL85N8PDP+o1Q9QjhTx5wd1UIKWprwF/rleg6GWjj3+HjDBta5mxJJB18bHGFZ7GRKaWi9izw9cdnybYRKOHuvUlmSzJwz5CO2bTa6UJj0R30olLIioUitJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJt9c9Y6efQNCBkntazbbFvnsc1l1Ap4M5Htc2yRYv0=;
 b=W9k2lxIWXYU7HaYtY6Z9K5rhbyfJxtSSOlm97RkcFXl5Pari8+JeatOALNvSBtFSwph39sGZvNqcY6IGo4pmjLMjDEdarFzdIATwVltm/J5Yt1DVQMM6j4jOjnIeynR7jAwv3YuDPaqWcR4LmD8miB9Ja9HkteIZUoiEoRuBcOU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 17:15:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 17:15:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Index: AQHYSDE59w1vuFTbRUqY9YC4imYEkqzvB5KAgAB3GACAADJWgIAABQ6A
Date:   Thu, 14 Apr 2022 17:15:26 +0000
Message-ID: <20220414171521.bgdvrirumd4atjhs@revolver>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
 <20220414135706.rcn7zr36s2hcd5re@revolver>
 <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
In-Reply-To: <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19913605-9fdb-4dde-e99f-08da1e3a5e16
x-ms-traffictypediagnostic: CO1PR10MB4500:EE_
x-microsoft-antispam-prvs: <CO1PR10MB450094F12DCFECD0FD3C9F9DFDEF9@CO1PR10MB4500.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4p+fdcDjy87z8GyYk6OI68x0HmIqmQXgZVUH74tuOyM8N1BHswtl7vBdGzjjzkGVktIuczHz/FsrwfnMxFS95RI30+OQsAQx2YDfl2fU264SRDpo4rjgF5Xqthp6lvlRtDSoRnHZlEvHPM8np+u9bApICEYPNAW/tbh+TuWVw1zWqZsr6nPLUasZBw5OjJOtDT9XyWKQahbPvInJIiRIly+zHpCy3an40nm1fpg6+HdMImTn0ZEMFL9/jBFqJku3hFaGaJ473x2z1ZNh30lCnVYJuF0m8WAsT38OphTUSzYIPNAiKNBnFkP7RdqDckBaSXcFcBG5rfXztdvl9Jx7tGfR0/BNyDC9DOV+/BOD/M6Ofs0+ogwwDPAK7qJm+YUDN5bJkFauaDehitUipw3DXx6D+IW4b1wGMhJwkGGJDSg4orB0154rXT9+x3cBPcdH99te7gGKz3Dv99Ch5l+yVpr9Nz2s+nOFFFOUpzxpUpFA8T6w7kLFYveSzM+MgXVy+MsduiFmeNzN8wlZe2tMyR4Jy0FUQxKnOGuImoqTlcbIbUFV2G5RluXD9nclwXw9x8NqUd9X75gJPDKqO/SWtWzXRBMPp33zegGZ2dMy0yf90JmfHBwaMqAKxJ+e+v9q/S7ehQcarpyiOvwfdrwJBI1Dp8PVM0n30sz24QKVLfhGxfBKAhwDPE+GT9vtU6sRNwf+HJMI9pZ8QhjU0dC0+v9mbV9HwHu/3EyYT4nbDF0r4LEeDlGWe79oUSlxdfcAvRVVMA2gkA7xPHmvH4qygpuJpQ5cml5azQM12LFcI+CcXv5YkVt2SkrV3KI9pMc9unIwjnCGCeqbZSKhnf5Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(91956017)(316002)(966005)(38070700005)(71200400001)(122000001)(6486002)(86362001)(2906002)(54906003)(66446008)(508600001)(6512007)(66476007)(66556008)(64756008)(8936002)(33716001)(1076003)(66946007)(6506007)(38100700002)(8676002)(5660300002)(53546011)(186003)(44832011)(76116006)(4326008)(26005)(9686003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3MDmIzQ90C0dhOf7x5igvh5fcFz+XZ0KckxoG6Q2+uM7+Zu7uaezTrw0k1iq?=
 =?us-ascii?Q?fRdA5d19dt4hOlTYwdJ710+tjlZLLJhjEHdKpuH5azPlBNBXCf+VRTSHWGqn?=
 =?us-ascii?Q?R03xkgNrkehSirS/zIAOTydwktA8FEfmJ16jCqwOTPNqe7E3dDSvdRT3BbV3?=
 =?us-ascii?Q?XpTZ0vIyOyGQp4F6rvTu85UDaO1Bemrdgk5wHXhWPJ9Sv3AhRHwdrF5iHOVV?=
 =?us-ascii?Q?liMgP6A2Nt+EEM98gvxFySmTIGoSWako9W6/dRA7aLMH/VJQ5yvuqxqqx9Bw?=
 =?us-ascii?Q?8He6rY+tZ2ucBSxeqF4f/yt2obDjwqSsZVtyYxWrbURqLaDM3CldCTnchQhn?=
 =?us-ascii?Q?UnYh3C7Q/7rUzdpKPLrlisF5nCuqYus4S8V7HOb8R82bP8DfB0V2EPmGTFke?=
 =?us-ascii?Q?DGdvH2uiWUOVINXqciRjXcTZAOICjWWXQNMS91LTI7+A3vnmKmTV6CdGlL+B?=
 =?us-ascii?Q?hJyq5bVTlQFeagVCarJVCmB+9ZpbPHGHSq1C1O49BWstgfb6zpbi1/sar4V/?=
 =?us-ascii?Q?DK/YsugosCp7TFMgs1nRJOsut0AkSlTGNe8iSWH9ug5s55FAI9W/0j3xOtpx?=
 =?us-ascii?Q?yaR14w9VhfK67M3xbCfNZ4q4Ta/afVi8XvWkAb90Si2lu73svHiC+ZqktqNc?=
 =?us-ascii?Q?jcHBkz1uwBfulttMcieP1u6lZtKBf3xs9wTRn/SlsXso741yO3mM8M7oeTFC?=
 =?us-ascii?Q?gvIZDMBi0HrsrL1amfgPSo5M1XdSCs8EVEYYYIRHDYrI1vUbS28yLxf70Uxl?=
 =?us-ascii?Q?C6i34E5ghaTspfSGpsE7GHFrcml8VGfMGB0jwtpziRHyCPN6vXSc0l8eYlzI?=
 =?us-ascii?Q?vJMQYFXu3i/t+nP6wFvQmy4NLCTCOy+McoS4nguupLn0dijoz0qMIYg3+omr?=
 =?us-ascii?Q?tVEQ5+tBDhlsRZnaWUvNVOdzEroshRDmtZMQWXjmPtgCaAg/svF7/ueJJfNf?=
 =?us-ascii?Q?NjfjTkfBQhCVfC4aeK9lgFqgkfh4t+lz8+QeTGDFVh8DQQbtN5Bfr9cb9Lee?=
 =?us-ascii?Q?qfBNMX3v9un2zAbPZmUd9p1rEA7X5Pgjole/r6DbYtoFdiZeFMOfrUSF5ryF?=
 =?us-ascii?Q?aUPmDT1HtqfXQs22VZiEsALzr2rXf3iHgaQ1EBWLw0y4mtbMVikUKgf91xxI?=
 =?us-ascii?Q?OeeUN4qynIDb5Ja0RG94AnAnszruT4ludHt0q5Fnzek9Tr5j0JhMiei9MLI8?=
 =?us-ascii?Q?1JQFl6rJjw64ZrlXWLHEWXHqTtV+of+Z8W99Qv2rtDiIuKVr4hoMDoRzgf0a?=
 =?us-ascii?Q?2pszfd7M+gXT0bZnSMrcYZFDpxyiM6zu3uFeK7PiXN0gH8sCYxeKxO0Nc3VH?=
 =?us-ascii?Q?huvG3asnDJMsxU2Z+pjCb7rve375PVIomuOStdRB99NhLtLuHzrtajl1dPr1?=
 =?us-ascii?Q?e9EoK9duha/RdcKd2M52POPNXp10s8/3Cje7UjxadHdLaNJaqkLSmCmvrIIz?=
 =?us-ascii?Q?sEQnpVEX7k/B68Jij7LTsTCJOGVJD374aUDY7ID0mWwTH3l96Rrb1xNLqFq3?=
 =?us-ascii?Q?owr9uRLEA/zrymRgyddd3w5SKSqaKo03im7Zje3A04uMcU4R6Oho0O+lacA+?=
 =?us-ascii?Q?EGeKzbaHHn7ZcwyyM28TX3Gz6fq9Rh2RFJu81fJyXHCr7PRLIVVuF9NNM2Ad?=
 =?us-ascii?Q?sXLtOAHF8QjUiB/kndnZNxloMNqd67WONplhaGdkdu8sfu+milp9Ka1RopOJ?=
 =?us-ascii?Q?xbMfh1+R2aqGiov6EioVHY97bf3WYrxA91eZMuJrKqUDsLooqACMSWz6L9rW?=
 =?us-ascii?Q?nlaKbHQnH2CkIF5YWSF8qIhmSd30OUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0E9E45E3D9C1D46A209121E1BEB54D5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19913605-9fdb-4dde-e99f-08da1e3a5e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 17:15:26.1374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: troSgLKTaTi1HGrv7i257Ww7WL+H3xf2gqO/vfzCOO6MIyFjYETBtjGnZAsG+bGb5KxtPKXWfL04NavEslZ+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4500
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140092
X-Proofpoint-GUID: HS_82s2U3qHNwcggt2TcZ5oqvmz-G3du
X-Proofpoint-ORIG-GUID: HS_82s2U3qHNwcggt2TcZ5oqvmz-G3du
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220414 12:57]:
> On Thu, Apr 14, 2022 at 7:57 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Andrew Morton <akpm@linux-foundation.org> [220414 02:51]:
> > > On Mon, 4 Apr 2022 14:35:26 +0000 Liam Howlett <liam.howlett@oracle.c=
om> wrote:
> > >
> > > > Please add this patch set to your branch.  They are based on v5.18-=
rc1.
> > >
> > > Do we get a nice [0/n] cover letter telling us all about this?
> > >
> > > I have that all merged up and it compiles.
> > >
> > > https://lkml.kernel.org/r/20220402094550.129-1-lipeifeng@oppo.com and
> > > https://lkml.kernel.org/r/20220412081014.399-1-lipeifeng@oppo.com are
> > > disabled for now.
> > >
> > >
> > > Several patches were marked
> > >
> > > From: Liam
> > > Signed-off-by: Matthew
> > > Signed-off-by: Liam
> > >
> > > Which makes me wonder whether the attribution was correct.  Please
> > > double-check.
> >
> > I'll have a look, thanks.
> >
> > >
> > >
> > >
> > > I made a lame attempt to fix up mglru's get_next_vma(), and it probab=
ly
> > > wants a revisit in the maple-tree world anyway.  Please check this an=
d
> > > send me a better version ;)
> >
> > What you have below will function, but there is probably a more maple
> > way of doing things.  Happy to help get the sap flowing - it is that
> > time of the year after all ;)
>=20
> Thanks. Please let me know when the more maple way is ready. I'll test wi=
th it.
>=20
> Also I noticed, for the end address to walk_page_range(), Matthew used
> -1 and you used ULONG_MAX in the maple branch; Andrew used TASK_SIZE
> below. Having a single value throughout would be great.

I think ULONG_MAX would be best, we should probably change the below to
ULONG_MAX.

I don't see the code below in mglru-mapletree (62dd11ea8d).  Am I on the
right branch/commit?

>=20
> > > --- a/mm/vmscan.c~mglru-vs-maple-tree
> > > +++ a/mm/vmscan.c
> > > @@ -3704,7 +3704,7 @@ static bool get_next_vma(struct mm_walk
> > >
> > >       while (walk->vma) {
> > >               if (next >=3D walk->vma->vm_end) {
> > > -                     walk->vma =3D walk->vma->vm_next;
> > > +                     walk->vma =3D find_vma(walk->mm, walk->vma->vm_=
end);
> > >                       continue;
> > >               }
> > >
> > > @@ -3712,7 +3712,7 @@ static bool get_next_vma(struct mm_walk
> > >                       return false;
> > >
> > >               if (should_skip_vma(walk->vma->vm_start, walk->vma->vm_=
end, walk)) {
> > > -                     walk->vma =3D walk->vma->vm_next;
> > > +                     walk->vma =3D find_vma(walk->mm, walk->vma->vm_=
end);
> > >                       continue;
> > >               }
> > >
> > > @@ -4062,7 +4062,7 @@ static void walk_mm(struct lruvec *lruve
> > >               /* the caller might be holding the lock for write */
> > >               if (mmap_read_trylock(mm)) {
> > >                       unsigned long start =3D walk->next_addr;
> > > -                     unsigned long end =3D mm->highest_vm_end;
> > > +                     unsigned long end =3D TASK_SIZE;
> > >
> > >                       err =3D walk_page_range(mm, start, end, &mm_wal=
k_ops, walk);=
