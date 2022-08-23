Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0C59CFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbiHWDoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiHWDoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:44:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9666352FFE;
        Mon, 22 Aug 2022 20:44:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNwxWf018292;
        Tue, 23 Aug 2022 03:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=N66YtdjGQn/qzNEhDjA3fqB0kfWOOeVzkvCF3h20yqM=;
 b=BmliBOsyMphouzRiiiqOkxdiNqSlesXBd4cIJWudxPQNZtVi2PtXjEsztfOu5Oipxwvb
 s0VYHASGYE6EwSwO2pAJdlWOzQN9Cc+jS7hSNV2yBkajEqqwm1E5D01taWaUSUZxu84M
 EL/bHlwmdCJk/4ggEZoy7MUKhe4Nq25+4VMuf63vy9VYxlJx4uHfkkYW+Ns3VZgiElWx
 XRW/GJt+XFY00PUqJLGKAmBQRdRZ/NJdzJYfYfa6MT8A0ddcsyDBIOTx098j/IcPMlPR
 37doPszK+rHHjMe8jcHEZGFcakaahuXd1Quvd5+z2qfJiihI+SDFWPMiIQr5o6b+U9bO zA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e2ms1wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:44:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNNWDT005191;
        Tue, 23 Aug 2022 03:44:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn4dg6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:44:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkG0GL2bKoAn5GEJACLiWiIa3tKmEWzhTATD6QQpJ3H3G4b+mCbTFFWyDJND7DCk+v6QbJgpuVEeVQGQvrXdVKSkRQnzTa63cjh2unrD+ri1R+kO8GSon8SVgOuX6iOnXd2Cs97RZezbWA5dbP94JemVG0E71aH2SQV2Vb6sWYw72GHZSDGm6Xzed+uc8zrADLue/AzucBY+3t/ADbLsawCqQC3zotvGxKfr80UATvn5dwXG/Kt9txy/Yu7A/h2WLN17gl+CwgiBxQvpM5/eKehZd9i35QXGnNqwVfUNcvLyFSDP9rjs5TymhM0p+jlf+Au4J9JbmaqNLyABP8I4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N66YtdjGQn/qzNEhDjA3fqB0kfWOOeVzkvCF3h20yqM=;
 b=IYMjFp2bL7wyySFPmfJc09bDpGnDDshgNQ7KLv3AS5GIQMckymEuTpbSSgN9pVXQmwdWOKfRYpApCK9ahBjh0MLafl/B49d/HopH5IcObYe7W8DUlIoW9qKe/7gugAf6zXFxW8VDbEBEqB6UyMbyu30hSRe6CoIOOWMLG+4c4VCMj+nB6PNgG/KCESPtkpuUGR3DMfVVOnpUVUYCSoPOY1Ku2D+lsOLTOUHNBD3kZ4sjEIbVxyaouclVoP/tpECz9BVJ/IfeaU6ox6xZDS3gTb2waUFGuyVHTNRD4Li0+ESOxgkBg2ym+Y/0fzj0o0eXdj6YpIzotl3mNjKPaH/ROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N66YtdjGQn/qzNEhDjA3fqB0kfWOOeVzkvCF3h20yqM=;
 b=me+fJfI/+UnlBudXZ2Sz1O3VGr1C4TWkPuWwE44Z/K6CyJBNev7heiOiSuyzA3um+PdaRsE+lQb+mq1HwMBoHRmArQm8MugK90DNf3yuScoZIiAbp0Wwqu7bUSq2BTOwKgtXOTaQy+4mPgRBx2Ka4Z1lRxjdoKVWYwEt3XNxxnM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6130.namprd10.prod.outlook.com (2603:10b6:510:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 03:44:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 03:44:17 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid: remove redundant assignment to variable
 mfiStatus
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17d2zaak7.fsf@ca-mkp.ca.oracle.com>
References: <20220805115042.2340400-1-colin.i.king@gmail.com>
Date:   Mon, 22 Aug 2022 23:44:15 -0400
In-Reply-To: <20220805115042.2340400-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Fri, 5 Aug 2022 12:50:42 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b9157a2-e656-451f-cdfe-08da84b9c15c
X-MS-TrafficTypeDiagnostic: PH7PR10MB6130:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1NlwBuiuGAvlALXg7XNyI6Cb3lJuRkrxfuQBuQfS19Lz0eqQEh9yPYFr2zc86HuRTsN18XEEtAqahNDwrmaLVU6oMwLupu7LBwPigwvhX3iHGLOJCXUiMJ4qqm12c3O+K2Et9l5tTemMW/nEIuN7cGOyO6JLgyOkDhIyh5SeWEx7s3aU33Cs1wFxn86mdzC60R8mhSXWtv9ilC8g6pErNLHBmM11xJzO2ovIKeIMQ8igZFu9uXe0+rI4KpmcHBTHfQrWwwgYfYn+/79tWbj2Ifq1seaYaEkNKp86XUz5xq2y+pFY60UlO9ZKHz/dfH4xJZCW4WBq60CsMH8Wshpj8fT6wHCMbG7epHKrrQ1JLSYSAAt1JAgK8CEXjJ9NJMc52TKPl1oQOkDKmU+khn1eEGh3AdUdL2idWC4i0CN1MtdnAeCMBx53z+4m9WGY4IWl64LaJRZ73rGt4Ht/D8zy9QD/wg/U7bXtYBd0gTiNdmkmml8+sBiIku9C85CRMHMC0pNjkQNT0k6TtBXCeJ9Ac4U4tIYqm6k3IFXgDuai5KFX0xdj4WtdPqo3hgKizT4sPf3YoKAmOinqeVmPnH8ITPIcOjMGYqf+yQ6sUil8FE0gsSxqC+14Kn1XJhK+GPKapIIS8VFjhIUHM4gWcHHqgGxAhHLBFcTPKs5KxCl5f4D0bJWSor6BupwJrsrSIm3/5D5l5i1TEPVwA5cCpQqrFFJmyFjvjtFR9XHEce7BlzEc2sdj3GPFy2lnGouIfA6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(39860400002)(136003)(366004)(54906003)(2906002)(478600001)(316002)(558084003)(6486002)(41300700001)(6916009)(52116002)(26005)(38100700002)(86362001)(66946007)(6512007)(186003)(36916002)(6506007)(5660300002)(4326008)(38350700002)(66556008)(66476007)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y64F6HQZtyARdtuZ0ukay4hVI32erk6zpXtu7EwGHJgM0e/PdIChnH9MuNTj?=
 =?us-ascii?Q?4xE02jCvLlGJoAWkfrTiUJnBR4GL0JrL07JdJ5fpcaRtA9CfLfh9axv64mWc?=
 =?us-ascii?Q?mC6ZI01ofk3hb4zRZbUBYJ75q0gQDvhy6ee+oKlhuP7AiV/oURbk+LoDMC8g?=
 =?us-ascii?Q?b0H21crl5ojTJ2DnEgLIO+G76EGwwfRQ9ou4XDbIDpatL6LnIWVs8rhvy84I?=
 =?us-ascii?Q?uCnBGoL3lfWUp9IUOf2p/phvR9xpcYAKil+Os3R6WTAQxFd/+L70nlbWgTGo?=
 =?us-ascii?Q?G8Glqz6Ovfhy2G8iRU1ite03gD+UMzvxOK0xzwTDoFVj4G6ky42QpA1P8BLB?=
 =?us-ascii?Q?KX9NURC99euvfzos5EWzZUjj+KQG98JbIRx/3b8+OQxREpoNFr94KUj+joRo?=
 =?us-ascii?Q?uDiMl790Ox2t4HWmS2TFbRAJonqNlboPgq9FceA0ZWKxDfWHJSoc2nyNanfZ?=
 =?us-ascii?Q?ln151Y2q7TvcT5B8agBKlFJzzI8Rft4pQt9IxaW/r7XBN+NTj5/MMXldXJ7O?=
 =?us-ascii?Q?tLevGU+u90pUCZPYaTWbvVkmpWCacY0WfrUJph2COzeBefEBhiv38hriG3xe?=
 =?us-ascii?Q?FxVSik53NNDn5alwxpYQn+P4hgcfPKj2esKJ6nbibu1jYKj/MhjOegRDQFd+?=
 =?us-ascii?Q?Is+JLg61AJC/9i7jD7nC9vO50OspwFxyZFUwhZDaaAuw6P7g0sSCmRLFCstw?=
 =?us-ascii?Q?vTm1RPt14cwQvDBmiLMhUp2e+nJP2CR+F1tCzPHJL10DupxGwUQD0O6UUpMG?=
 =?us-ascii?Q?EPwD/AJ1MVHh0QBQWUvb9KUy6LZ0jvHCs0W/BBMJ++4VxNHpVtLIqWxgDUzI?=
 =?us-ascii?Q?leBQTz5ok5ZqjSk72s15k2Q3ExVViWJqVZx9yK/VbkelqOjYzwLXfuoZpfLF?=
 =?us-ascii?Q?yb6LeReFmIxOsthBAKuNdEMUTAdMnr+Cmx7D/zY6QgZwucrYxtS0aSXxPlxh?=
 =?us-ascii?Q?Lg5GqydEN1KrATIZ7gi10Q/XMPqyf5gfg8fxpewdZUuZmZ0RZk4jHu2Elsj3?=
 =?us-ascii?Q?KC3lU5mKTnsksr/HNdXcVBJpJvMCfX7v6BzfH95v9p8NHxh/Si2rVnQ45PH1?=
 =?us-ascii?Q?GXQy9Dbuv5YyURw24XQP9uEXWNWwI8BUARx7VgRpwXZGDI86bxflKYv4AP0M?=
 =?us-ascii?Q?eYyE/jGKnykOK0KMjuavsyOiER42mzOBEWBG5LCYG7oq7j7zO9btMyAUbUz3?=
 =?us-ascii?Q?/EvJR1tXtrMxmAKjecKklBPERnxC50ieYjR7BVR2b4jJmwKnObjUmaZ6oG2E?=
 =?us-ascii?Q?ve/cznnwCfztCG8F2QxH9dumA9vM34OqqwfdjHuDvHMiEFhXXZic65YZcUMu?=
 =?us-ascii?Q?YA6fDdYdAwF5sqxA86vKmtZVSi01Uhhd3zQfQi/iW89VpQL7sPzPR+ilTPZy?=
 =?us-ascii?Q?bcRn7WMg7Pl1MJq7x6JsXb3UzB/nR0DY4/jjGMAvop6pmtDJUUtVFLf9L3hP?=
 =?us-ascii?Q?vzMEw/puQQ3ooC6DQ+H8djTd+4Ngl+l+fM4VP+yqMevXKDvuSfsC4SYGncxf?=
 =?us-ascii?Q?HTcE6hSrRPPoM5oH/a8F4jbHrn/SeWaif2z2jeu38KuG2B3FcHUxf2xJaIXu?=
 =?us-ascii?Q?jVMItRgtPIdhlA1WSkavVGS0AmIJflNeYEkk2HN+WcQ3DOSn4h7Ze6cbWB1M?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9157a2-e656-451f-cdfe-08da84b9c15c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 03:44:17.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKav4aeGS9V6KXXuIqBBHUKeltTAd1805aAkEutm2JjmM4GiIJ0trp1Z7gzvPsIf6XHBeqv+RH/LvUeEP5aZHJA9uKRUyU3cCvKwdJE3qDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=965
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230013
X-Proofpoint-ORIG-GUID: 89178jyz5UBAkUeq_NTfUXR44z9ibas2
X-Proofpoint-GUID: 89178jyz5UBAkUeq_NTfUXR44z9ibas2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The variable mfiStatus is assigned a value but it is never read. The
> assignment is redundant and can be removed. Also remove { } as the
> return statement does not need to be in it's own code block.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
