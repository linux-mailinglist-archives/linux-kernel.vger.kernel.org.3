Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0214653A91F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354824AbiFAOZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355886AbiFAOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:25:11 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456555418A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:15:01 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251DoNOa007800;
        Wed, 1 Jun 2022 14:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=/Qia8iAcfvlDo5gmsIPxySqA3LmaKtHkHAAtf1dDngk=;
 b=kfC4ma7lbwC32i1YW6SlIVWoqV3R0NsodJ+ZjkpRoaaxMsMGUuVPkBhDmgu4Ly+mSD7b
 GRaOa11/ulpvGTEGWpY22QPlapy6FabQF8X9pWnmAIdhLcxfzYL2Cv552tk0ATsg59Wg
 PBTqjIsS7CNjJT9/hmuqWgmPJH4YL2au6o46ZrNzfgWPjYEAsbsLGRG/4IiHjt2/OvZ8
 PkgHL38CrpQ6zmLuS26+0cQ9yJRSEzUaEgwkmCCiNV7ypaxARVxbQpAH955Z+xW2Y4KN
 JFvAp+yhaWLxGfEZ8sIOI42hyTrUqOk9KIRP8bzOVLDdVPBYRND1CEkq2zJ8qHxGOpc9 5w== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ge9bkg8r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 14:14:36 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 68AA2806B40;
        Wed,  1 Jun 2022 14:14:35 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 1 Jun 2022 02:14:35 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 1 Jun 2022 02:14:35 -1200
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 1 Jun 2022 02:14:34 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpH9OfptW3QbRTbU8x64RG3KpYIbBER0eP5GjENIyN5NdWLpdHfT8N8EjLSh0rIVOMfLO2JBUxUV5SueplyURp7Bfs8tQFsvA7qMwm1uVgFsj3XIVCTJDNAm/K5uD1zZpkWOvw+y6JTe/R2947roQI9P+SFfO0hmJrSIKoorozOuKnYE0mo+Bpv4il27A+Z2xvR7PoKgG7Q228fS3FljXgXyjrlA+vWT1RRQ7QB57OrzqNrM0hjb2OyiKxfGXJcac84WpStgXex81rWADS7aJcXjHhckOmnpwREbJ0bbBACNJIYa1oyCsmd/ZjxEvxjE0YSXMeYS0RCtpWDm0dIR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Qia8iAcfvlDo5gmsIPxySqA3LmaKtHkHAAtf1dDngk=;
 b=muM4EkjbLwXZAfSTFVqFW7MyMGArE1pJHJRFFVCJMmqiTxX65KTQ1yI3kCgoQ641kIfOLzmeEz8fjJB87B9jsL4YtJG0bbe58HEaGUGvpo0QH8PBhOTJV76uRv/trpJdST2D/Nv3ObrtB5Fzv8IikhAjlVtm3vR2SfHRZF83eFLNXbbYfkVt3UkdSooEu/zeMx05KxsC4smdSX5Cg+pra6Aspmym+Ifl3wrrSEK9MHWFuLXMtiDfiibexsFtN5mshPZ6YSnNJoMVJFhSNZ1j8XxICG2D22RKivOs6DnkkuThRqPZYK9WGM1y4WJ0WfnMW2pztbdby1p3uMy+QEHUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB1372.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 14:14:33 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::152:caab:fcbf:4e43]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::152:caab:fcbf:4e43%3]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:14:33 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: RE: [PATCH v7 1/8] ARM: hpe: Introduce the HPE GXP architecture
Thread-Topic: [PATCH v7 1/8] ARM: hpe: Introduce the HPE GXP architecture
Thread-Index: AQHYYX0xpitDmhpioUWxkMbNvoYPIK03JJMAgAOaLNA=
Date:   Wed, 1 Jun 2022 14:14:33 +0000
Message-ID: <DM4PR84MB19274FE59381E204CBCFE55888DF9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220506191339.78617-1-nick.hawkins@hpe.com>
 <20220530070626.GD1363@bug>
In-Reply-To: <20220530070626.GD1363@bug>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 013e82ca-04c8-4b55-6829-08da43d90d01
x-ms-traffictypediagnostic: MW4PR84MB1372:EE_
x-microsoft-antispam-prvs: <MW4PR84MB1372551B91683360FAB4551588DF9@MW4PR84MB1372.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z5MqOr8M5Ov2N8vI4bBj0WRX59m5ek2D44LZZXVyaotpKNHlYkvwwdzW5FiU2RU8gfT8eeSkFpHQ4EviL1gUFuSk8mbH/ZH59B82Odm1LaXtn92Em0kFLlIheTaLJvy2lszJnRGuLQG2pLbOwEtVrsf6K3y2PKaAFZdZeQ9Cq4yDUQiNVh2nJOCQeXud/WAvFCHmGqT3qQHuyhkojQdZbhc03Wi/g6jeVom60CuGvQb9lz70IhtyczxkHerZo/VbQrD588KIT/jsT8oKl/dXMdfA0/IwUBUoy96RinyRNsmtCGktrDOL8hT2WcCy+EYlvlCo0D8n7xRrG/fHNVzR/s8GCXy4GadtXDjtIJnzsTCCbNLYYR/WQ32O85Ro0cLQUblwJ8O/u+1L3LVsRQYYH0o+v/QJUWihh4A2LS+xnz5DAGijGWbGMPazVYKTbz/7Hvvg5wS5NbP07RZAkAyLH7YUejQGE2ppzMiegHfzZvpuEF+9UaxjNii0KjnoAmfvh1MWdWbMIbfI/XPQPT63nk5bnGiv0xtr+lk9EwKSL2MAUOlC0SlBnGCg88lu08pHd7m7Wbc37wNaq38OszkINcd4N9Mr1cfX98IDCwwlGa29MlJzJnRMtrganKKTOYABMpacnmmeqDUsd2HqnD6DD2/m6m3/g2EzKXbcpVFBqktyAEWJp9CDz7AnqF71XIhgOunmmvRvYLQ8kGE0b+bJjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(64756008)(82960400001)(4326008)(8676002)(66446008)(66476007)(122000001)(71200400001)(66556008)(55016003)(76116006)(86362001)(7696005)(6506007)(5660300002)(55236004)(33656002)(508600001)(186003)(4744005)(38070700005)(8936002)(54906003)(52536014)(316002)(38100700002)(6916009)(9686003)(26005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lsegeRQkBkDYOOt3vgkY3jEnwYvEfqvIbYnDr+7Kiit8HGa33dWlyfnzJCi5?=
 =?us-ascii?Q?0OUDGVrqsgYgkpS2tjZ41L4EfoRwjWIcjfhIWgI0Ka3pcmbj+W82v2a12XLV?=
 =?us-ascii?Q?Emcao3CNfWInsyv54T6demT1mOK21p2lVxO6b8HZw0c0sRjesXeZNxxSUyBg?=
 =?us-ascii?Q?5Ibp5ycQbb8LNGwquj8+8I/xN/ZsmtqrRdXyzKmyNDQMPTYJTY1OgJrElTOd?=
 =?us-ascii?Q?ZAMwtBn7M+/Eeqt+sgL73eTu0l/iciEAmL3tic0hz9clAM6Lr07PAP3YC9my?=
 =?us-ascii?Q?aFiaPKX5JE+nsXvv24F+dys0yzZZ+l99bPbmaC5jPkFsdOAUM6gyjyE5IUiD?=
 =?us-ascii?Q?F/ZBOMd1l8v1TZNiJ0xnEYaZZW+g9J5YOSpZ4ibZcecs0zVwJ2LEVa8rneCG?=
 =?us-ascii?Q?rF6EQKqvFtsAKpCLiZOmoJK9SP/+mZ1HJ60X6/d2BM7Qq0LVR5+6L1fPr/K5?=
 =?us-ascii?Q?sQ7kw0S10a6RuI1JVbx/TeVUgo/HBLgA2nqv22Dn2l+UmfBDed3Tuwg/Hw6k?=
 =?us-ascii?Q?dEIFl3TIFfdYX/82XvZ0GNmU9Ec2x9lCAiFSqR5/2Ysihr8CDY0MLFhOboLx?=
 =?us-ascii?Q?5CCtFD/CURywdXUPHiqUf0G2Z41m+hOraA5u/Sct3QWaNzY9/A3mMj+yuI3k?=
 =?us-ascii?Q?F9RvpeZnny9WznrdnMZR0426L+Epzg+c70s7rBY1mOrri7U79h4FrYqsxbUS?=
 =?us-ascii?Q?XTJu4NlycdPt4XBOSxvIgh1P+PGJftFtHc6N8jQZ9bvn2+3nZ+UyVGVzOGxr?=
 =?us-ascii?Q?amOcshUznJaH7F4yCZz8hG+vFxeIo3OcSf1Njc3DUU+nCyr59uE1vnFi+1fw?=
 =?us-ascii?Q?/29XI1ymz1W141X7ThEm8YvyGW4nCNfEcWcoLIyPPyCcQdZfs995YppG6yrc?=
 =?us-ascii?Q?yi7YOQmGPQreIVTOcWR5IP9/pMyRC66NH3axbqttHI5BJYGVE8StP6S0j5AZ?=
 =?us-ascii?Q?oVoFo19I/44VFhCX2L9im0PA70ekj6GdeAJCfhAWw3pNhxROvzkMtiC4NIBC?=
 =?us-ascii?Q?kUxLpWHdC2NaUviDt+aytj0H89WuBV6DWF/dYupzSGvkUU9FvjotGuq3jysm?=
 =?us-ascii?Q?Ifq8Xjmo8PuBpZghyNvOj9NPfFrfykX5ba93SNBuDK/zMQ8m4jVd/BJzuxkq?=
 =?us-ascii?Q?d1yr0k6rltQk4AJkaTZWNFVGmHuYmM44QHr/fhpb3EV+LsDCp5TK3cGeY32u?=
 =?us-ascii?Q?fcqCRWst1frVawOZjTWq6OJVLTx9J2bEgkq29UnBI857A5JzcMlCbu49BbaU?=
 =?us-ascii?Q?9xpFsRWCScXEOWrrY+53+GjMTX8s4basStTztMGp6E2zQIiLwO/yCau7/d/z?=
 =?us-ascii?Q?loaoIwDRYgGmV0GqkTVt4JLixaua62oJ8h69TmdKcco3BTd2xpr8g/UywXmu?=
 =?us-ascii?Q?GO/ozFH/mNs+b8rTKNHL14hapqAKmRIB45Z/X18bbiQD5hE4xfSelan+G7Lz?=
 =?us-ascii?Q?2S/shVA+BftJBKAOp53A6NF3dUfxfQcVfhdVGsK9FJt3IayDLpSZ4dOm9nPI?=
 =?us-ascii?Q?okEaUssbxxe5V2ZBpYtxi1E1cBn+CODub+SBPZ9/9T4wV3MXSmqki7MoCXD2?=
 =?us-ascii?Q?ixkB4+hO/Iur3YRnAwPDchhYd+vHZCiB2bx6VLa4vJYKfVtEAYePJKbwoBOf?=
 =?us-ascii?Q?BQdZsa5ZSR/yo10EyauxZFQmDnJvXeLvdVaRhPBkIxryUeh1y02hZhy0TAyc?=
 =?us-ascii?Q?RUd3UHkz7Avc5qyo+NdVYG4OCKevubljCihW7ShQI+XvCindmt8gnkpUwVuP?=
 =?us-ascii?Q?lGW5+Z/duA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 013e82ca-04c8-4b55-6829-08da43d90d01
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 14:14:33.1038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCF7oiqRgKhlSgEAZVT1OJgo+82o+A5oHG6LjZK127TCnzHvwgT1mCgik7wSqJ+sTx2C8g8OIeKVePGtrZ4tEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1372
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: a5hTRty2z9tVOIH_1rsJWJWPzoBIAdxQ
X-Proofpoint-GUID: a5hTRty2z9tVOIH_1rsJWJWPzoBIAdxQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_05,2022-06-01_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=779 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010066
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Nick Hawkins <nick.hawkins@hpe.com>
> >=20
> > The GXP is the HPE BMC SoC that is used in the majority of current=20
> > generation HPE servers. Traditionally the asic will last multiple=20
> > generations of server before being replaced.
> >=20
> > Info about SoC:

> Normally, 1/7 goes into the same thread as 0/7 mail.

Hello Pavel,

Thank you for the feedback. I believe the code is already in the process of=
 being merged upstream in version v8. For future reference can you elaborat=
e on what you mean?

Thanks,

-Nick Hawkins
