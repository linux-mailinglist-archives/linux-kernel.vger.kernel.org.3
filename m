Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C97561F41
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiF3P2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbiF3P2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:28:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD1231374;
        Thu, 30 Jun 2022 08:28:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UEnuDJ009047;
        Thu, 30 Jun 2022 15:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aR84levBeiMCbAynF3n844iIhcha9XuNaTaOe1ITmpk=;
 b=np59r3SpdF24DoxWeIRVSViaUfIX22o3NbuMoFWOULriS0QJEkUu+NS6ECVDX7cuc83m
 zB+MgC6ZnOf/IV4CTBrE1URTwUEaDzAHJ7l0/u39MPTXjCKHKsMzwXWkWO+et6x6VNYd
 ESVVTnviNpkVTy3PKDbwU/BBtEtsgnudy/ctyW7S5O+qr56Sn+lpRFoSVooebbxiXUcX
 pekWP4+4hMqdckqcr03bEKLFW+/4UsUOrlI6H6geVHz8H/L+xbHUEyeTTRaWH7pmIcqk
 ERy4MAO2j/BWX6ZtR22BlXIOWnRa01Pbtgt3vO5v8LJUFlT+nrSCjljeBwOkBwn+J3ko CQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52mqn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 15:28:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UFBAxq023207;
        Thu, 30 Jun 2022 15:28:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt9vrn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 15:28:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMmOYDEJHknktyENHfP/V/G14FJ6q100OR2I/blkGcvz3ja7VGd7zrQJFQXQJsxDDiN+XVD9AMVd9MfxW1lAVP34kts3e5L8mC9+SI8Dv+sB7u5QWnM3RiIHgSLk4lb0nZUgMA+CR1ijQZXmhmwAeGdnxMMOpVq8wEPRoFlK6K/BX7uGdyFnNPFjs21yI80DVVxxatNMCTB4TyTs7H4eBxSeuUlp2ebusY2ajLlsFd6AGnXpWoFKn2znYDWI2COhH28HWNTsvfUaUCwECkBB2xogb4Pvh44L3dndp7Rq6qmfEcH4GBIWD9wQ+UwrwBT5wYv1i8i9GekMy2hg0H8edA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR84levBeiMCbAynF3n844iIhcha9XuNaTaOe1ITmpk=;
 b=iRDrDzlEWVuCTDDxBHRgzbtTPfgKBtGErtlUJL/aOqG2UKMYYIZWkWJeYd8xAAwG3ZnfGh2diTujJMMZqXz/xFGf8WY/WN2xac2lr34P0gwUypxhvkn8EByqVnJTJwxpmRt79KUAt/SDEvGDUZycr3V8JiC2tpVbFIozObcxSSGRMScm7sbMZPcXlB1M9Tar18ORUKTdUw8FBIU7fT4VIBpNwHa0MGOwUwO0ZhJ1YQ29swDMaylk65rb8Bjf/5HyQffvSJ3JFyH9NsTLMx4ZkPoSqEk436dLGZVVcJM/sV6CpevY7OO+d9y/ux8bNWF+fotMggcH72Qk+VJFiLEkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR84levBeiMCbAynF3n844iIhcha9XuNaTaOe1ITmpk=;
 b=IqHAnWcoiCU+pGpmO4Y9HnVlRMmygV258/2rKr8a6/IhoTDHDiLhj9J0tBJO7QCrsf3xg5x39nvUIf03LuLCSjmQxygtb9cwubnrUA7pXPkxdch9ibq86oDttMycgUgDIglwB2Qkr+IMcZDn8pCj+osDBU9rn4T30qGWmZlWSYw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2804.namprd10.prod.outlook.com (2603:10b6:208:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 15:28:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 15:28:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Thread-Topic: linux-next: Fixes tag needs some work in the mm tree
Thread-Index: AQHYjDK23cEpbGKXvEyM5HDXl29HiK1oE6QA
Date:   Thu, 30 Jun 2022 15:28:22 +0000
Message-ID: <20220630152816.pyqzoluhmv2uivpq@revolver>
References: <20220630133712.1a3b0ff9@canb.auug.org.au>
In-Reply-To: <20220630133712.1a3b0ff9@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4efcd746-9b2a-46f7-bb03-08da5aad2b61
x-ms-traffictypediagnostic: BL0PR10MB2804:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1fi82Xq1p2N7G059knR4R0YZmefvQxlTc6KdLLZAqTOoEIgnCDIJYWjD6OtckIW5+Lcltrovh2IhQbTOESj9KbwmfPlsjKyvAFyKpcNv3V5WDPNZFawEp+f8mrm2gx5P8srNkHoMdytXEmOFkDaGynMwFDUmscQZd+nY1ltU5ODBt0TWCxGATPOSPClNEDRuEvHo9+bWTO9GJ058lSTJAHHKEDQPThZf5MMUk1cUHp2hjNWEseW53tW//DQiyVAdlzbp5RggnKi/24CnxlYtbFg6IFUAVJRbwc3fj/y1bDJ9po/ATW9/6hwtPdC7q0G6YPFY9v+gt0xHuBkmgsV0KkBYOLLdIPiwM9AuSi301+L/unb54pZQsvGSlezVL0KNfESS0sDChwexnZ6ZoRJPlrTSJUnQJQbAVOjTDUZS8LppEFByaZcieGrSt9yhPH57kZl0EKg0+T8ViR5e24JYwH19583Q6w69mUt5sQ3mtel1ZeL6QdGF3A0bGg42Mnu/9dv4jRhXzjhVrK2AO2eF3+Hpt+6pvdz5mZ13p6/jbNOWlHiVkGZc9RRO6qk0sc454brWkSJfDR1F7RY/mCXY4Qu+ZfPxE1UxkND7dh8RDuQUrSvIV+FQpuriV0d5G5/85etYE0FzPR6fgeriLXw9s742eIlDHqh8OoTgImxraw0xpDDpRPtKW2193TSJ4qXjE2H8Di38prJmR75cobV3eSTNNdOqPVXbfTaXy9MjB/4F3PJBQJjBUNg/VlWHNs2Bq4fisIihgY4s0TSwZ5NJUJmJ34yrM1sfrz+/J0p01CC+NtzoJtLvcIxsKHDaow8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(38070700005)(26005)(9686003)(6512007)(8676002)(5660300002)(478600001)(8936002)(6506007)(2906002)(41300700001)(4744005)(44832011)(33716001)(186003)(122000001)(1076003)(86362001)(38100700002)(71200400001)(6916009)(54906003)(316002)(76116006)(66556008)(66476007)(66946007)(66446008)(64756008)(4326008)(6486002)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J9ehA5GLyOBaw9Y+THlVCt3Ozwmsci0yeoUSjmVzB3PZ2IaCZOWSAiVjkO6W?=
 =?us-ascii?Q?4mrssoXDv4jGLPXqx+6Rt6VD4GJ+J5ovu9FlKH7foPjchdxJEa9C0nWQk/w0?=
 =?us-ascii?Q?nMGWWbLrTgblJFx7g1sP2G41SCG2+eO9HcTF7TPPHeq19v9oC6uwN34vbRYV?=
 =?us-ascii?Q?1wAMkMc/iBa0yFq9tpP89baOmI8RSr62xYlWoRBvrxafY6bqrzj+ZtgvdruP?=
 =?us-ascii?Q?bPMn9ursBc5FwzK/WmbrthHzZ0/ZrS1aXrr1v+GNmfH3+9DCdFtuE4MOJo7r?=
 =?us-ascii?Q?G0n+19pHtl6gHFip/oP/EvsnKrMaubPkKYNn3V4aBy75ajIz1/A2l0kPDHdW?=
 =?us-ascii?Q?aG0mPm205cUWOmFzSLkNI2IldoFl5n2agNPGVQF7AAzp5nROidJqugwCDTM0?=
 =?us-ascii?Q?reUczNpAqV6txwashYWJf2a3/Y3TUisiAdfGlpktWMXZViCOJcH0jQbj1QLN?=
 =?us-ascii?Q?wGlhsnBY5Ny6QHUnAQdg9pVoeBw/OFO6gFVv046RwmLObGcz5i/fZMeY2I1K?=
 =?us-ascii?Q?AF8qz25V4wWTdJjko6ec09FA572BTDOKqDpWspEneh083Jrj4KaGxwO5m/ki?=
 =?us-ascii?Q?D7AjDnKEwrm5Kdl4JOXFKPUfjmL8I4taC9UCgZuFhsssjCnIP6M0rgGufaQo?=
 =?us-ascii?Q?ALGSzYfaJ2QN0NyNzEcR76TY0NTflajmc2UBtzSrsglqhMPXKZy/y74ZNafM?=
 =?us-ascii?Q?yzp4sDD4iUUGcYraHXETVwUdsp7tdd7nAFZSUNAWoIUs21uvFWigGjE9faDF?=
 =?us-ascii?Q?XGgmyjwuXRcoEBxmiT+kOjVh8DqxKSeJr/u5VmPuM7yuo2Tk8NvDypkgI1Jn?=
 =?us-ascii?Q?D5YycQCcALD5aRLWGOvpqyDofHdZsYXfB6v6DF7LodiawcFTBc/owRTfzLr4?=
 =?us-ascii?Q?ampdgZSVs4XvhKWjNDrmg4/X0HjQJCiuLlATKe9zivCRsUjGCKfJE1NHdmKV?=
 =?us-ascii?Q?O8lret/n/3TSjom/e2CRyBYUho5ZeKnBkawN2zBGUxeNazkN/dWIKHodKNr4?=
 =?us-ascii?Q?Jv/iMcyVsS/FV7NGSItEy4bBBPTisHdiHgOdMAsfbQOr68eMWOI8yVxrPd4a?=
 =?us-ascii?Q?Jqx1C1Rrk/u1Ij5zu+QldHz5WIlZ9zSEO7DM0l1FjGCSeHlV3CJzCrULDL2O?=
 =?us-ascii?Q?fuspTKcDml+SJcNk7se5ivmoDktn4HiBgcjtdoHBV6uERCmt7qmcH1DAp8Vf?=
 =?us-ascii?Q?7SuuuUenAu//JbWtVkIwicMqLgFl0QH9NEpUXVqzXA2Pw0hYv9jmTM6Rm2K5?=
 =?us-ascii?Q?qqoUm7dK8WD0I5+MaL4osqFi0pbhMkvkR8lMFN4dAILk9D4joZNXfz6LN0wi?=
 =?us-ascii?Q?XLlyZG9MID5+t31Ac1D1/TWYE4Kppqmt2GcBxHgeShNT3Ml2+IuEXBdO0I3D?=
 =?us-ascii?Q?A6NFjaS3vxyelZP1CUaIO2KStynD3SFmXYoVukRhNV9Jvornw4e/MhQ15Fwk?=
 =?us-ascii?Q?GxQNeapG0iAgRHtEeeNXXFfptcrf4Eh9//AaCqc/ZXkTFisHmhN6shEjZWG4?=
 =?us-ascii?Q?kS6xMJF6H1leiJ9QTS8HjxP7iGOovyhqdOYjcn6Smd1XJMq3uJZ8RpYyONHn?=
 =?us-ascii?Q?kzz2+FOVbXq63VWsqoF8ocitIPCdCl/G671NxTVQjf5VfBrE4i9baphdH4kL?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFB6ABAE3670274899E6EA45A4EF07D1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efcd746-9b2a-46f7-bb03-08da5aad2b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 15:28:22.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bc3+3+AWcPUUDqg0kekDNttm7VR0mDNfTMo3wYq0qIn1hrM4MlVYo8Y/rHA7CgO66CUan2L2ykefMtcdWiB3Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2804
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_10:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=972 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300061
X-Proofpoint-ORIG-GUID: W_REsbXx__vQv4daHRqXRH_s-2dBuKll
X-Proofpoint-GUID: W_REsbXx__vQv4daHRqXRH_s-2dBuKll
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [220629 23:37]:
> Hi all,
>=20
> In commit
>=20
>   500caa69a5a0 ("test_maple_tree: add test for spanning store to most of =
the tree")
>=20
> Fixes tag
>=20
>   Fixes: 1d3ae73e4e86 (test_maple_tree: Add test for spanning store to mo=
st of the tree)
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> It seems to be self referential ...

This is a result of an added test case then getting fixed by adding one
more testcase to catch a corner case.

What you put in the branch is correct.

Testing was added: 502cefe29b10 "lib/test_maple_tree: add testing for maple=
 tree"
New test was added, fixing the above: 2197398d8d44 "test_maple_tree: add te=
st for spanning store of entire range"
One more test added, fixing the above: 500caa69a5a0 "test_maple_tree: add t=
est for spanning store to most of the tree"

Thanks,
Liam=
