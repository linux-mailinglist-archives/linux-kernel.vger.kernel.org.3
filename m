Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B598358E970
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiHJJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiHJJSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:18:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F343AE208;
        Wed, 10 Aug 2022 02:18:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8hwi8013170;
        Wed, 10 Aug 2022 09:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=wr4SxyiyyKY7agT/FITEN3HE5MBOoHaZPcwZ3xClie4=;
 b=Saj1N0ML3GO4uep7QKHTE5sot1596d74Q/tlOWzM+BSSsofJlm+UawO132t6zF9wYOmz
 vr1ERQCpnL6luYpr+9xXjI8nm95O5V2NxwlPmax1Mvevj/N61ioRWZdOm8VE8f2iXSJJ
 kWalcL0v24XviI/aozgcOOdVw1+ju7xECKxPYxQDnmk1UhsflisD9d3iaXKT8cJHYYbA
 U6WcUBhFrKsCsQmchXspk/20BiN3eEAXS95CFFEZg8rxfToPUTbz5T7nYu+mZSgB/dqH
 6fVF80/OLZEScHI5vU7+QBOGKNJ4MAK0v5EZnPTe+l4R80yeRL8fiD7ubU60rDuEQtzC Pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqgha9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 09:18:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A99hCo007505;
        Wed, 10 Aug 2022 09:18:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqhfur7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 09:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLOCXJ/e0qlDuHsRpv3SsTDcEF8a1Yw9INWhWslZj6bPN46p4dNzBgFz+Z/rFUDeVx9oRPGeDLpQHK0HHRCajM+8DsuIU9faMBBPLwuPWyd/BoFRR63M9u0J+Y9nOAJr8epztwtsCbEOhLGi39UIq82n2m8pYcMnKom6e/nXZP942kvqV9NMgU1ha0gApz+3PI1s2F3bbZkAe7PvHS+g0U8PQ5caPvM/mdOkvudY3GJE/NvtwtzNRtO7AAOR7zBifjnTrRGWdn0XJpyInWE2y/Vv14r4YRFBzk+CTm+2OmTNHjDMMiMBsQ3t8hbYigi51YtMdKre01mmZNkRS/X8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr4SxyiyyKY7agT/FITEN3HE5MBOoHaZPcwZ3xClie4=;
 b=G6pYxAh/PboM/ba993W1iJO0ZCm30c0Sd25bprI/wnwacnyW5K0tdxPNZtoKS/pO0ZPd8MtUTpDGp5NtkS1wUksnRKvrLnthlETcKI0ACY5GddVgqfwfNTCH/9z+oLNsM7FKFhMNIgbIXX53z96vexZEn0rhEXNOma8IOyhmx40rKVSnGbkGTCE6X+f6PhFCxmQzXsiBi7XS9yoAPfE/05PpJ5vpmFwiqwEl6jgt4Z5k2PLWT41jOB9T8wZLdfI7KrvBOa2ftxlGioFVybSs/y9dR/A1eBXaokBWKlkdpqJ17Xk/Mgb5ofjvsqQ/1WrhSAuE7c0TXop+Tx7+xQ6nCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr4SxyiyyKY7agT/FITEN3HE5MBOoHaZPcwZ3xClie4=;
 b=fAWfSrViWcV5muvQCYC6jWtrHC2lf3GW8V6z8IaOlmP7HsuaEAbGkwXOcqbOOS4ovpuy41bL0blesNgv1w8yJ0RzcpKd/4sEsxzPl7QQ67JWjqRlVUxa4NMZUQt6sHJ5KfjDuj5q8rWbou4Zz5U8SlhGoNkbt702np40y9f1yAs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5281.namprd10.prod.outlook.com
 (2603:10b6:208:30f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 10 Aug
 2022 09:18:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 09:18:19 +0000
Date:   Wed, 10 Aug 2022 12:18:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alan <alan@lxorguk.ukuu.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] get_maintainer: Add Alan to .get_maintainer.ignore
Message-ID: <YvN30KhO9aD5Sza9@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804191913.6f52bb6f@fedora>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0040.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7bd2675-754d-4d32-be2a-08da7ab14409
X-MS-TrafficTypeDiagnostic: BLAPR10MB5281:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvKJRfqYp5+uqEbXTuvYbiBXT5fxjtKnFLFZu5LwYiI1EKr4k0YXideWAp5n17y14SeNACk2Dxhm6JJl28IFuXUIABSuXZENeHrT055Up5d3C1dqI0eMVMWpyjtLNCzaBeMegseM7Z7Iri+wSXzTbGsDk+ULVraFWLcAhn06CfUmTVWfLtzaI3f9y81hul6lLhgIVcgfryWBQvhDHeiHalAOpFcCfC/Y1a6wBZrvsgHbqx94tw/iHhKp4U8s0bfirS0yYUP64ex1L5br2ux2eHg2TP+vLoA34KdmTtWm7mm8XlvUYmxDyR+9DOX3kWDalRzZwmRveG9a7vYKhD1F+aGuSCPPaJGlI7pEqDuw6mze1zFzmdOyBiBX90lZ/M98MIZyw6wkR4+SpkNAPpzvhh3m842hNNes1Bn01muBp/CT48WKWlfGxCW2IdnNLRPSXve7j3lSHp+qZUoQ8CpeumQnX+StvJGSqAi8/vGCZFCIcRVoi2PNir+m34nOK0s9PFlnL4hPQBwJ3zETTK4RKLLhuELt1zwSwjFrhkSYJCQuGFRb2F469uzxoPpDYPLLvxLGnULsF3N7omQmzAKIHY1+C3WEmU0BzCF3JvV7a5xm8L+PsN7dbEBy4i0jL64zNM/6YZ+ReDRK81cUX8OqjbUQ1ws5yEHmqie/OxvDqdf/V+TX+7R8HdnoeMJ86kDE5Zw1nsJxr+qZl1wfPb10mhNWLk39zRAhVkdgEy7fJ89knO2W/PvIEEN1f1l5krsvS3L9br9d3hpRYE6k91nKvgmLyk7NCoYyfhsom77MgMHSFYglD4RwS9Jd7qIAQ6n9erHL5TdT/YzQ/Qjw3VvPKCDWhJb+VJRz7B0zPUZpSdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(346002)(366004)(376002)(396003)(2906002)(38350700002)(4326008)(8676002)(26005)(9686003)(6512007)(52116002)(6666004)(6506007)(186003)(8936002)(33716001)(4744005)(66946007)(44832011)(41300700001)(5660300002)(66476007)(38100700002)(6486002)(86362001)(478600001)(110136005)(54906003)(316002)(66556008)(142923001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4/1/rJVp6xUH7WfB2btbAj06ReZjtR/F6xuks3azd6St9X6jaTqQzBGSbYG?=
 =?us-ascii?Q?BgOLcnQItNdq5N1DVd4IvgXmUDn5rolqf6LVWzFJmn6Pt06DfZBQgSlWfcgc?=
 =?us-ascii?Q?M3d/y1IhZFxsm6j9ui6xYReiDOCY40LbKJ+W8unCZaM2e4RR1kSGFmF4iWJv?=
 =?us-ascii?Q?7Wu0z01rPJ/crNz9jTeJlDit9jVavIrEp0OovU5EnD9uxsm5k6YKPsZYkZBs?=
 =?us-ascii?Q?v1KOUDz4avmFE2DuGCddEIoeq1tYj5sjf3AjNPaVYx7jg+RbH5+1+00DjzDd?=
 =?us-ascii?Q?BfydYwoSlx3qf7mhxr+odteRqhAFQ83oGXnvClQNYoZY6NBgF84yQZww8PoR?=
 =?us-ascii?Q?xa7kwGX0WuLoPw8KS4OjjtRYy43rlHcK8AHr8rY7AGYHHZXHzSU7L7f+4m0k?=
 =?us-ascii?Q?rWGuKWqu6yye3eSAdBnM0UnJBEHa5fJOPwLmGS7efoAKjX0Ufhi6VlmmBIPb?=
 =?us-ascii?Q?33Z3HphTEYMXlW+yDMuJtgI4wEva+z7llBiez5Q38VUj9tNaBHRZ1Y1ny5vu?=
 =?us-ascii?Q?yMJ8XVEAUkmKe14D36q+kezvUnj/rU1QcDe7RJELf1KUmgtK8orqkl7MkpZo?=
 =?us-ascii?Q?25NTZKx2ByKUuJ5lkYoj3bc+JJ7tB9G4kEI321QncbHRX1WgOeqAOlAiuWXY?=
 =?us-ascii?Q?ay9dHzarROk+LYhYr1SZBIUIqB8X53Zg6+gnqSKHRZK8f2ckdib9BY7Eg5Z0?=
 =?us-ascii?Q?XsVxvhgKrwPKiJYCmrstKRBrNK6yw9iuK1RFHdcNVx3nHQn3x5gukAs7W2Qn?=
 =?us-ascii?Q?Vxzlu3ecfvM2I60kR47uq8HMoTQritJtGlEAM5bzeU1XjLiNy8LnGyIzh+zP?=
 =?us-ascii?Q?6p1JkJObAMl2jspmm09ZYYAUPU6Lp7q556R+bblhqchfimqtqNp/ZiX7rr/x?=
 =?us-ascii?Q?TRVIeoxepsYRTxkLiK+km4Yf20oSQUyK58JvOjvWoCREr1aJzQ4KpPIGNulG?=
 =?us-ascii?Q?3mK4wNXsyFcA1YJ3wJ6wyou2ZD9pUCO7WYw/OCL2wvJ/fXsyiFsNKuJx2434?=
 =?us-ascii?Q?9ClryPNc0ESCZZBfT54+0BK08hWAB6/qXYa5WrQkM2iMd3Y4xhGK41s9x0X/?=
 =?us-ascii?Q?PwglsHwqLngnn0uM7byW2omiG/X76ThFp1zk3xrakTO+nHEZgZWsHpATk4nC?=
 =?us-ascii?Q?ZHl7OARTVGKCH58xWSycOYuuI+tK3ZCQex83qPcsMdfvPuUCq76ThK9Rl/K8?=
 =?us-ascii?Q?GEEtQWafuqcRRZZO1NSIzYF+PF0OQrenTixT2+gAYluH4WgKy9aTNbUMMrFh?=
 =?us-ascii?Q?0FWIFPgoAVXVzPhbIPOYZS8ziYgAfhzGcYKTB2Kk1a4RjsJhH3bfYDUE1VJF?=
 =?us-ascii?Q?jxgJKVS4ynZFwxKrDEPmlgBHJOyILtmwwsp2PSyGzyWZMHSSWkovTZZwUGGp?=
 =?us-ascii?Q?JlH5Dq9/2sW6RvSjZ1OiisJWvwVJjvAVD2wFqumhv2md/cTDiP0OAZ5BC/6g?=
 =?us-ascii?Q?uFCCD9bPneFd6b94GuFl0bEN3YqhsGFkqxntKM6EN9c5WaMIt1h+chZQlGU2?=
 =?us-ascii?Q?qh1zTqzRdoe2o5xeXzNtYzrSXHMcSJ/eNC5CHQXKuM3/XZ5vYp02GpMqm/2N?=
 =?us-ascii?Q?zg8Jq94Yr7yNDnU835hBqomek+YVllFBNlsRBhy5XUIGOd9ajsZ+72n2+g7g?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?af2bsDF9ds3Ch6I7Xie+7+E3UtCyD4BphPYgX9jzEF/gNsl6RtmTKCN34ixY?=
 =?us-ascii?Q?wlH/I4138FDhW10TJrXgepXRyLtp9ZmS+xzQXu+u4pdpj2Zz7vGc2wQc+zgT?=
 =?us-ascii?Q?EvoGFlREk865Hsbru3mjt3k85E/8xr6AlTFbX3RHGaLxNLQfuepXehkBg4LF?=
 =?us-ascii?Q?6eqgVs3BYtoGPyQ4wGQqqww5edX/fDl1EMuwXg7U2/T9zzaD0ZmSgHBcPOhJ?=
 =?us-ascii?Q?MshhfWmedx6lP0Cn8PC2elJ6BheuDOALWtHcCJDl0LUxVzo68pJr5rwPR0a7?=
 =?us-ascii?Q?YjNeAxrAD++Ci+T4nq/u/rr/ZZUMlRG11LXxQwpOfJ7Y8u7/i6bn3/qbLM74?=
 =?us-ascii?Q?+nXAm2v+O8CCvEpE6HK64+13wzweHbB30/eXYpooVQSwMKbN2/zGmKMdLsKG?=
 =?us-ascii?Q?kbneDIOAokww5n1OU5RocdKqYfo9ER7Eq8iZi7K/eecGCnWVTDNYuajRYwHC?=
 =?us-ascii?Q?v6rYPMZxWmZ2UE4v6ytDSNWRFlJBzknnK8Pg44oXD3JH3SXOccvxvO0PhlKx?=
 =?us-ascii?Q?GsQ91fWiiMZzKAI3Ckvexrr0NucJ9sr2VTlTr4CwWzjU40qA1HyEdCW2xS+Q?=
 =?us-ascii?Q?y+x0dNIP0vJDfZmBj5QEXRpNZkehh+smPWmkysPOwXBjJq0PFwCQfkRm9UMi?=
 =?us-ascii?Q?9a5U9dLRI1QzGGdtaY7U87fZP6vgeRkf98w9uxZr1PfBNFGK7tW9170E2mVB?=
 =?us-ascii?Q?530HRF/AT1MRyns2IQcMkpcwguj0+2J8UoafNesuqP8gKCJjNj51jtyETKIo?=
 =?us-ascii?Q?TFho9t/1NKjheG2wVS30UCk08WYycsY3zFdaRN0/DK1sBSxwo4e9Nkjv69wX?=
 =?us-ascii?Q?PEvsvbk3mFk0bhEgEngJuQ7ZJ+fDlu7ZjXwYF70EOnk93tog6SWJXLR4PrnC?=
 =?us-ascii?Q?/LFN7IfEWnGSborS2g8zrxgV+NT4xuNKRfqzqbbKSvPWo1pSy2L3fZ4At8Eu?=
 =?us-ascii?Q?ie9nol5hSY4j52Ea8cKDrAGTag8hZHMnd00QTlqHeHmvklI2i4tqXC77HG7A?=
 =?us-ascii?Q?MZzPfMgMzA9Phu1CC+iFw3D/dXq/cYCFK3lrd+5Qx7UCtus=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bd2675-754d-4d32-be2a-08da7ab14409
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 09:18:19.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtuhqFBQCjNkJpByYfPhjWnXvsoEPX+iXDKqr6n+cHRxOYKMarnPxYl1f/f+t5mzbA36kob2vut51Dob07aXltTr19OBitQjFIcPPo4WSHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100028
X-Proofpoint-GUID: dtjfGHIxMf6a41lii7YtR-SublAs79kw
X-Proofpoint-ORIG-GUID: dtjfGHIxMf6a41lii7YtR-SublAs79kw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan asked to be added to the .get_maintainer.ignore list.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 .get_maintainer.ignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
index a64d21913745..c298bab3d320 100644
--- a/.get_maintainer.ignore
+++ b/.get_maintainer.ignore
@@ -1,2 +1,4 @@
+Alan Cox <alan@lxorguk.ukuu.org.uk>
+Alan Cox <root@hraefn.swansea.linux.org.uk>
 Christoph Hellwig <hch@lst.de>
 Marc Gonzalez <marc.w.gonzalez@free.fr>
-- 
2.35.1

