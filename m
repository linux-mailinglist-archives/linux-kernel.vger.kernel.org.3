Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5F52ACDE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbiEQUix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiEQUis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:38:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C5C427C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:38:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKZM8R008024;
        Tue, 17 May 2022 20:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5VPsfTzu6ESg1KQzXOtiVa4z5swYP6O6i7qZ5WTDcPY=;
 b=zIfqX4buhWALAAK14CI7Pw8B3YcgFi4myHYScVGlNHSITFRAg0YEeWEmn6UlvhwVAYlc
 dFzqeSKi7eTG9B3EVXcczYUPHGjGi+PPCI0WGKn4LOI6Ei4sLMa4mfXmo2W21O3ObY0G
 uTw5CStLedSIfePG4HR2x35ZEGKcrtovVdqwjizoCxH6N2hEyscRFLIZoKLUjFnf51/E
 l9Y77bLoWpIyNYN4TGvz+2ZsnmzU6IXVqQkSyXYRDtQag/GJu1VhxYi0N89Is/aJJO5I
 J3BLUuwEgjnEp56zValSy3RnhREAObmi1a2fmphgQjmpRkNs+JFKyX51WLtuw4fjTmpK hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc79wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 20:38:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HKTwnr020807;
        Tue, 17 May 2022 20:38:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v92fn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 20:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fT2RsGpsNQdYaLElzZoWOLb14Y9QoWXUKryt2IZoLooxPwCejVwti63l5NSv149K0AXefymbYc8ETSkMATeCyTjoYohi7MjpSjiUz5o3lvY/svrtm4ZXkp9KfwZ26FfJ+sbXsfc2j5KbraB42kxHnp59HkDW3kx4zVKECspxqAxbgM07Bp+6h6wNq0s3ZyKkCebLGlq2ba9X7221SS9JHw0IoPdc8Rgr9TtsJb61oM0b654xtJIS/4hIHWnkCnT4VhIF2hIBXQ6E6TqA7uD4jEWKScZCEIkBL6r/iBIOR1e3enaAsvoYpqHvW2KTwgPQF0OUejBrBDLUrlvsAhgkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VPsfTzu6ESg1KQzXOtiVa4z5swYP6O6i7qZ5WTDcPY=;
 b=DemLn7J2lT0GauwYh4teKXe5b9u8x3lpEw+aI1b2OWqf+BoTArxnIcQo5vrOfb9kwtCQxwblD8ttgNw/KQGSrKDerTHwdgndMWFztuRE/ytSV2uMQuuUafgug26rNkWjzHm8m9sA7ukjLac6Rx6V3d0Yq8jO/8/Ad9DP2j2Wo9eeWL1aY+aL++qc/kEDGu8QY3DyZha/orKEtkp56/D9mOIHjovoZUwdJOe+Fx3SJbg/K7yCFeoWV556Mw3YwC5LFuJhpsi5jhTlY4AbrI9z4yrAepA+lafI9fbFFHTxKBrImtMFtGe1Sxp14x5e+AHOs+1p/nhcMhJ2S0Od6Gz5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VPsfTzu6ESg1KQzXOtiVa4z5swYP6O6i7qZ5WTDcPY=;
 b=Tf388QMnsGKB+ZEPrRmBl4rP5GyXctE5l7vHOhpEcPX5bX/vVBOFZrbpIvleVoXofFAW5nNZCE2bZwFJzHCMVW2RuBEZHyRTfLbeAFgxHqKUyOptEHd2auINGYmMq/8MttdJ4EkW0rWeWyhzU3Wa1PzEblkvYlQEBf4S52uJAGQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3701.namprd10.prod.outlook.com (2603:10b6:a03:125::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Tue, 17 May
 2022 20:38:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 20:38:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAIAF84YAgAAZIQCAABv2gIAAF8sAgABFywA=
Date:   Tue, 17 May 2022 20:38:27 +0000
Message-ID: <20220517203820.6hqasgwn27go6ltv@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <YoOMsmq24FWsWWyr@osiris> <973b908d-7098-cbae-8046-9a42cfabd570@roeck-us.net>
 <20220517150219.7mshct4jkne6c5el@revolver>
 <70537c1d-dbd7-b8a4-0a02-e6773a5e68ef@roeck-us.net>
In-Reply-To: <70537c1d-dbd7-b8a4-0a02-e6773a5e68ef@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25bee620-0666-462b-a89a-08da38453275
x-ms-traffictypediagnostic: BYAPR10MB3701:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3701CAE2F9ECB9BEE5471C29FDCE9@BYAPR10MB3701.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPzoGSfqgcvKzIj5Su3Y/0XWLyV3DADMT4LYYGSM7pIpnO5EeCOKzr9byIU1JxwxEClD+y3fCGqS9fO5KmGjIcwXUsnbBHA8+AHxBZk67Gv7KXOlUxL/D33LaseaCzA9eLFOU4aAjeUiz6MSzTG8PKHWfOZZiN4DzfXEKU50SstLhouwUwvBf4Qa3DUxGh0S/kqqhxzJ52ih4tR/S9W+i5bTv7v3l9hkNUm8RW9WXZGbzx7icLvQP8qzL2cLY7nb3PXcTE/GqW6aGfOG8agkkv52wBRDBvn9AsrhfetM4JuFRJ+bT7a32xDsFrSO/Cjir5wnMI6XPH2u7oGrkDL3j8VFlERUUljFNLj53QeiE0/wVvAct4mI9svGmPCpUOTFS4Fkt3/6SNiYRY0kiECi3Id4bFwPOsclx83TosLdsSebbfPNP1kYfJYZWX9uu4YK5g0Tc94abk82MCZR+Ct4hyOiqJuy7Xq/O24Q4oVrL7R99pUOcNvbelNHGAchVebNvGFJjkYDPlIfD0avG8AtO7nNkPh1GUGM6fdSKdPRqXIqyljiaWOx8pOVimRS59NmKwFWR+h1Np5tPWyTLrHYUb+Js4mbdGnAo57kGWNMPwHio0bzjsA7SQEU7/pnh+7duwRmGQutNW/yEoyqGAoQfEONVYvWEqjkDYuxgdfEAEfLYwK6GpfK4TZpD/qdHg7+T7CZLb9FdofMSG6Kx+Oqig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(6512007)(53546011)(83380400001)(1076003)(54906003)(71200400001)(6916009)(186003)(6506007)(66946007)(66556008)(76116006)(26005)(64756008)(66446008)(508600001)(8936002)(38070700005)(66476007)(44832011)(122000001)(316002)(5660300002)(33716001)(6486002)(2906002)(4326008)(8676002)(91956017)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9v+e+BfPgeTBmK3vZFkRdNaIEbXr7gzyOhBZiAGDLtiN0g7s8jhaJGMQo8TN?=
 =?us-ascii?Q?0JRYSy7b6pmQTKqagbbcHSlJCQgFeVVeoMoS2mirjjUrK5rq77Zm987MGmhm?=
 =?us-ascii?Q?PVkKQXYU6MNZjLipe/9zvn9W0fY/GXgvuVKkrGQFm8xThazFIoU1ovPcV6Nq?=
 =?us-ascii?Q?BzpEfdEqhR9GkBuBOgH8AF9Asvs/7Nnu5Xgjzqa5dtLCmrR/V9T98gFZte32?=
 =?us-ascii?Q?4fd4MM7zoJPn56mra+R7bUiX55D2aFOzsG4JFs4DDwIT0dUaZH9n1RWoEp9S?=
 =?us-ascii?Q?0i5I2UXQsJrwbZf2wL3/2EzY7wqUWqfjKKOFwwcLel1Rw/9ZmURlZV6URX+0?=
 =?us-ascii?Q?tzOBxWW8RKTKZB+GF8GbfpV9otkzEvSmI/KUMfWuy3LT/YvfENs7ZpWJlh4Q?=
 =?us-ascii?Q?RBMKNiUvlijPx3a0pfvzmpRrOFhCsPRS9mGJZWqpXuHRvw6qwZma4KsOfrbL?=
 =?us-ascii?Q?hBv+tHLfnaQECvuF+1xxSNRylvn42g5qwqjWDCSTGOBaclbTSe3azeOCKJcW?=
 =?us-ascii?Q?4DTBpOEhYJamcx+IYETngf3RomkrkanoWotNP9b+BPLNpoOwkxOYVHVzyT8I?=
 =?us-ascii?Q?7Ngl0Jv8YIsaZD7YE+wIEHF9vV8bJGFngC1nbOU6xDgstYqlCSU9xzzd71Zl?=
 =?us-ascii?Q?DBmSpcxdBnHg4N5Hi7bn3i/JD3pSQPS52T/0ccD3pQXzTy0vCCXAC8aps65v?=
 =?us-ascii?Q?LPQ7Thbddlst9Ey6s69qlECcy991tn1tYF8fSlg8nFAHcTqoq2Ls8XKp8VqH?=
 =?us-ascii?Q?glvWhTiVtG7K+1fh5/MhhSwRhTADxH1fKOPEUOklaXkCCAc1L/looqBl1f6U?=
 =?us-ascii?Q?Vov7VR/yI72/pvy35r4j3nVcSn64dFTiPQQslVAkLPpUFwfuGsLcg16PoIKx?=
 =?us-ascii?Q?d8pEgAMqZm7Ptokz9Gq+K8itWo/ajQbtzvIx4olqW8bk/hVwM9SEkkYFWMQb?=
 =?us-ascii?Q?vQQEiwKFl7/7CkftuRpRnBFw9cUISRck1HNCfOtQVPzMU2PE5kCs4jujM5hE?=
 =?us-ascii?Q?28PJFMwobZiWdL5mzuvZo0yNUvl/jFrehkxACwuX6o/0NjsYIk1oq42UsD7b?=
 =?us-ascii?Q?1KTYDwaPZHAmNQSajXQx8n4zje3BMzLIG9Dw8/xWrEQZMEkmvgzNstgPhQbJ?=
 =?us-ascii?Q?D25+u3wtBCB3woQMYIKuxUvfptIQ3Sf+j/Qm8Xzjq0FFI/aPSYpGfKsSCyph?=
 =?us-ascii?Q?vDcdNGsdNwnBP2XmJSk4cOxCWzV1/f4Ujyxuw5zE5mHD3j/Q87Tav+aeqIut?=
 =?us-ascii?Q?SetagKmzUnHSCrLMpsbdXPoDU7xCN+nO+IHQmhlLfwdkRTUM98VOKMfSY9VF?=
 =?us-ascii?Q?VHG9LSrWpfi1RaMm6zPLnqBgph4hNt/wfL74cDVwnv0bdrExf1w8HbhjTQHD?=
 =?us-ascii?Q?p/9kLPjL25QPLm4RMd9HO0mkCxd5AApZvYPYTsqety5MB02ELEVuQn87IgRC?=
 =?us-ascii?Q?kIM/5U/WD8M3nsiZxYLlTvGYwkELNrGd+FR0VMvNLZ6ZdLdimhTIWX77kFtU?=
 =?us-ascii?Q?tg4KE5HN/jMjozaPcNR+sZhy5NjJcaoKTpRYWmqLQDBibZa3+c17nYZaIFGE?=
 =?us-ascii?Q?LdevFTeDj5otrtjpyFaXXFzrydXSzBxuxBoivheyJvk0nwcHQSmv7dqk65j1?=
 =?us-ascii?Q?5BI1cDWHfEqfBKimeX7jo9c0v9XmIOLlC/nBhTLTBnx3sbtSiBUUWa5jurxx?=
 =?us-ascii?Q?Wrt2+XHfdpd/q7JxPcIfV3C1aR9IKjIhzek02T0IG4Mxs2s6ZqvR1PDAVe+r?=
 =?us-ascii?Q?fqKJab+qhJ9eg2Dqm9oyUVaFKnbCPUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3894264B03131441A2B1C7BC7DC08A73@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bee620-0666-462b-a89a-08da38453275
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 20:38:27.6348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nO/WwvDcWCjYpPnSl6H5+qb+JureDD2/XX1KjGx5xMMaeDJ8tXuNcH4fiUpN9T2dZDxJeWrWIt9Guj8XBXMeFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3701
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170117
X-Proofpoint-GUID: urhkN9xRh2O5wxvrVoEgJlulsndIgUiE
X-Proofpoint-ORIG-GUID: urhkN9xRh2O5wxvrVoEgJlulsndIgUiE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [220517 12:28]:
> On 5/17/22 08:03, Liam Howlett wrote:
> > * Guenter Roeck <linux@roeck-us.net> [220517 09:23]:
> > > On 5/17/22 04:53, Heiko Carstens wrote:
> > > > On Fri, May 13, 2022 at 05:00:31PM +0000, Liam Howlett wrote:
> > > > > * Sven Schnelle <svens@linux.ibm.com> [220513 10:46]:
> > > > > > Heiko Carstens <hca@linux.ibm.com> writes:
> > > > > > > FWIW, same on s390 - linux-next is completely broken. Note: I=
 didn't
> > > > > > > bisect, but given that the call trace, and even the failing a=
ddress
> > > > > > > match, I'm quite confident it is the same reason.
> > > > > > IS that issue supposed to be fixed? git bisect pointed me to
> > > > > >=20
> > > > > > # bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
> > > > > >     'mm-everything' of
> > > > > >     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > >=20
> > > > > > which isn't really helpful.
> > > > > >=20
> > > > > > Anything we could help with debugging this?
> > > > >=20
> > > > > I tested the maple tree on top of the s390 as it was the same cra=
sh and
> > > > > it was okay.  I haven't tested the mm-everything branch though.  =
Can you
> > > > > test mm-unstable?
> > > > >=20
> > > > > I'll continue setting up a sparc VM for testing here and test
> > > > > mm-everything on that and the s390
> > > >=20
> > > > So due to reports here I did some sort of "special bisect": with to=
day's
> > > > linux-next I did a hard reset to commit 562340595cbb ("Merge branch
> > > > 'for-next/kspp' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git"=
),
> > > > started a bisect on Andrew's tree between mm-stable and mm-unstable=
, and
> > > > merged whatever commit was about to be bisected into 562340595cbb.
> > > >=20
> > > > This lead finally to commit f1297d3a2cb7 ("mm/mmap: reorganize munm=
ap to
> > > > use maple states") as "first bad commit".
> > > >=20
> > > > So given that we are shortly before the merge window and linux-next=
 is
> > > > completely broken for s390, how do we proceed? Right now I have no =
idea if
> > > > there is anything else in linux-next that would break s390 because =
of this.
> > > >=20
> > > > Even though I'm sure you won't like to hear this, but I'd appreciat=
e if
> > > > this code could be removed from linux-next again.
> > >=20
> > > I finally found some time to bisect the alpha boot failures in -next.
> > > Bisect results below.
> > >=20
> > > Guenter
> > >=20
> > > ---
> > ...
> > > # first bad commit: [f1297d3a2cb77261c10fbbd69d92bbca700108e0] mm/mma=
p: reorganize munmap to use maple states
> >=20
> > Thanks for all the work on this.
> >=20
> > I was able to reproduce on a sparc64 VM.  I was returning node metadata
> > in a rare case.  I just CC'ed you all on a patch [1].  It should apply
> > cleanly to whatever branch you want since it only changes
> > lib/maple_tree.c
> >=20
>=20
> FWIW, below is my bisect log for the sparc64 problem. It looks like your =
patch
> does fix this problem.
>=20

Thanks, yes.  I actually tested on my sparc64 VM since I still cannot
get the s390 to crash.
