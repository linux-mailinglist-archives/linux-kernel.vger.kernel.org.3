Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436EA59BA58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiHVHee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiHVHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:34:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023BE1706B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:34:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M5YpDe024310;
        Mon, 22 Aug 2022 07:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=g2YKyF8biB23I2hwe2Xz6WaUykKHMyzb9aPNL7bSTBY=;
 b=ua/cuvtEbB35JiBO1jJATihqmDY8AQNX95NSvzsAVv5y8BxEgJ3PDVWgQEcmULVwbJZ6
 zXiFP71TaLchRQjh9T4bHmojpcc5e25aBvVj3rB6+/CDKlXevVDENgRmuJfLq1ZI0Xqr
 3lNQnKICC7wlchYockTrb4t3pFYlTCpEFnh/iYPRXQenWy3JLKhiRQfd9eDPPO8eDt64
 siZANOS3c4VbQv+LIKo07JL0XmRsWWf4jwE6C87JPEzSPhF5ft/3DawQARi4DGIv4IrS
 NF+psk9/q+fNRdNfA07h4/T+bDEL0OkMPecozHzc7KsV9gYS3PQ3qksZcIWbKiJlhgFY mQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j43sb0823-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 07:34:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M5PS1s011194;
        Mon, 22 Aug 2022 07:34:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm7ye3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 07:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLD4ahdbkChKWpTyuo1IFPtavgALyx7yaWL03iUoAD9auN3CVgyZrOhv6avgu9sAffS5dzGuO53SXDNrq5IYiGq9Rxho626slrRC64m2UA4ykGHXWFvE4fGXRKrsR9FExbK+yQjBILWmf+G9Z99pEl6NTfH8CX6p2LSQci3IqRaKkXwiJVJN2uQG9kd93OhS4B2RW4KkcSAwpjlcDry7RGThfzDaKR9jgEAkP5YZ/bZnw1I8el/jC+PnA+tAdb1f8D7cIjimpxlVeL8d348tr2FdbFkvy1ohQpVUTvdqycy7iV6nNt041fY3TBPpXnV2esqaz6PMB74uA0MwMG6lrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2YKyF8biB23I2hwe2Xz6WaUykKHMyzb9aPNL7bSTBY=;
 b=b3AWylHHVt7CgisWW29dFG1SfIgPqvd6DfsQzq9viZhxU34cYx6zxu3OpETNsiw0lJcQHtF3udYLvqwbOMEenfjpwbETIdJJ+7nseCAcrCVYt4U019mBoboD6rZgZBY/DkDUzsXDVhl1Jpn653yYDuv8fZRpV3hlehBtaV0fhCJPK2TxuBeNANavlgmwmPVMMf+TPWnzP+4wfyVg4TsTOCRx45lX9aKOFWiaPB2txtr2fNJ/QYcRmk9EQuK9bREk/RrCeCSRJF9aZhFtUVSRp3wSRCcd3uE83poCcy61NvjA2WxZFp/i2DCjBIbwtqig1qyAw3wqfjtQGudWDfllNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2YKyF8biB23I2hwe2Xz6WaUykKHMyzb9aPNL7bSTBY=;
 b=Dx3/AOOCoPQwBu8S1edF4t1Cbpn+UXG+o3QTMXIxtGMnV89cgF0L+EF9uKM8HRgOwibqQjN/MCdqxGrdFvzFqHorshksnQQ3EKzF9O9YeXWD9LEO+0Frp6kp74suKMVEXtnIHY6AnSVcdobDHdn6fj7849fiXnmkWShfF46H0Bg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5552.namprd10.prod.outlook.com
 (2603:10b6:a03:3da::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 07:34:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 07:34:11 +0000
Date:   Mon, 22 Aug 2022 10:33:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     lkp@intel.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/8] staging: rtl8723bs: remove function
 rtw_odm_dbg_comp_msg
Message-ID: <20220822073352.GA2695@kadam>
References: <cover.1660916523.git.namcaov@gmail.com>
 <7ff2d658863db4fd5eecc1a53f682510c2765c3f.1660916523.git.namcaov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff2d658863db4fd5eecc1a53f682510c2765c3f.1660916523.git.namcaov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d7c1930-cd44-4f55-4f48-08da8410b496
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5552:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8fJ7QwJGgkrASjT1RipvCzKl7du1rshtPUykJWaho9vPYPclA5GayoNXbc3nBsIrdbXvKuaEgLpdO8Nk5w1ia8jinRr16PMi4BwzPqWZjpJpWtkOqeNi8B0QYggQTm98BHMPNhkpmEiH0/VulIo9nhuAz/PrF+AEiPBxojDVWKpELwTAe6BBWBtO7bLkz4Cs09x0mNSL5RS9z7jLJ4cQ3ISVQmt1Ngm2kReSrSQm8AI9JQla6IXfj9YaVCriWfSngwwh94klIATBlz0uehoeToewR3XZz/VdzQ1VRKiYVNPwzhxAszMDL0RsW7kChZNaVeL5kGujo2pRjNatvFOOlwT2v3Ojk2vL2yf18hPYMuIdwCwxMwH049xJ07Y5NodxzI6SNkQZRsGWh5MZiE8L5JqqmOl2Euc4tgqEbzULauqAGjZqwYTl84A0qgD3sogZP+ad9BnYIVl8dfC5HElOuWjYbxtulOWjtVpIRsaeG1jq2e4rtZzJf/joOyPAkZWHpFMmgpPo1RrP+MDNqwW8cr07hT9OUbHy6vGi6JlvPG8iJVxvdiuUoLD9/tS+5uKy9elQr9ytMX/qk8uRAcA4m3vFc0vUkFsWeeuCffpXWSs1+c+tIGfyHrMZETScZXCP+QnuGtfosJL5l6ymcp1epbWv43qWFho/LpA/bjHzNYanbz3Jo0FHlZaEQw7u6VDoT+pFZAOUPDPaeiNpncAXubRCw+M1HDjF4hBwkvr3/6WDJDS6R9U0ggdi0RdhHjn35dCHjbr8CE8RBFoxh4IctE+BnBsKRbzwFfMdQ74Iuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(6486002)(966005)(6666004)(6506007)(41300700001)(478600001)(52116002)(186003)(1076003)(83380400001)(6512007)(26005)(9686003)(2906002)(5660300002)(8936002)(44832011)(33716001)(316002)(4744005)(6916009)(38100700002)(66946007)(8676002)(66476007)(4326008)(86362001)(33656002)(66556008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1t23li77Rllk2wfQ0RH+n57/3Z/tLzKdlC91zMhtR7+vvR8lNVVH+Y3IK12g?=
 =?us-ascii?Q?3z6yG/J7Br1hBTnL+OKNmfiIfwZX94wC1GVkC3MEGlo/vVjzqYdhcLkYucAK?=
 =?us-ascii?Q?OQrxQEW1lnPOs9lEGLWRJ+Hf0oqpMkFTaZDEima7MPdL4fdFKK4a86s89/Eq?=
 =?us-ascii?Q?qH/hAIoSED8+sbfJDRH+2+AIFsKNhIvXJpY90m1CID7xt0mRKzchWWI4Jc8C?=
 =?us-ascii?Q?B6i+z7UvNj1RwHxuwco43Rvkr634aWcqOfOE7CxCEqzrSyYosiPKUILhGs9q?=
 =?us-ascii?Q?CyhOv9nw6pdNKuF4ULlYX4sMR6reNQ9aH63UcuOYvAitJaku3AxsGC7ZbIPj?=
 =?us-ascii?Q?FdX/UVIkYN29Vql3PkaUzZI50MsFqnq5Ex6naTLDAEcm6FxM738pHLHeltoY?=
 =?us-ascii?Q?wmQ9kCPSg3aY9t/Ux2C4WUavEZ19q8uArhF3fKCRh9S9sCGdZuRl6hTywZbH?=
 =?us-ascii?Q?KaXT59IObmm0nevP5zROYpv86uENFXmpdijufWyOn8RSVXXO3GLI6U6y9PQS?=
 =?us-ascii?Q?TCrtFm/S/CCLqXAyorIJuSwKsC98jnv5Au2fwT9e69iF7rSf/eCPkNdt2jtk?=
 =?us-ascii?Q?gD9+wU6ZmnKit9JfEEOtwy6lbITagDT9HngyWx0ThkKfZ0orXNnR7grE3w/s?=
 =?us-ascii?Q?y79t+FSgW5PQzJJizp0RAq+w5yCEO7qt0aYzf2CnhVPoQfB5XrcfM3aI8Ibd?=
 =?us-ascii?Q?c4t06kcIbD2DTH8yoTZOisvRHL7cSku4zy+JYmnrMLsPjxueytgb0F7tgSEn?=
 =?us-ascii?Q?YQONPxHE93jvoyIsumYysyqblslKV81YwXGdkJfsFG6BWSVxBHsi2GZi12sa?=
 =?us-ascii?Q?ADaEQFBrkPTMCDZJxoA09hxOOwo9FxLiw+gtW03B5cR6qfeZnIpWfYoqyXE0?=
 =?us-ascii?Q?X4tQQ6/xzbf7waMq+f/pEtm1lvXe6s5zgbZtL88Qa2I24NbIsHNOmy484UcT?=
 =?us-ascii?Q?enbXY9PM8+VXRb5TCbcOUV6QiU7c9QqXcMy/LIyKuYF62b3oRR6EeRA6wuy2?=
 =?us-ascii?Q?CjRSzJRJ983JiwYxmylef6vqzYPHdvlhLbVEqujoxD7t1k1WDl6eTuR1BXRR?=
 =?us-ascii?Q?dIxKTKD3q63n6rotsTn44GvUvopgUzfCIMtLDEL13b8xNc5YQSJda2AFUVbw?=
 =?us-ascii?Q?OXOS8sWbcrKQ0Ivk/Iaxxd9eVQK38jvtKUasFyFs3QigqhgjjiU3+Qe6Lp3L?=
 =?us-ascii?Q?juNo7oOsGWqMoH1rxcZxkbcNLL9sViIQw8R0YlujCva2ejOBIwd5LmrR+Vv7?=
 =?us-ascii?Q?6ADTuQy7gsqQyARPBZE+T6qHjp/omLjsX8jTk6CPQkh2a7VTFEGycqm87M3n?=
 =?us-ascii?Q?h49q58QiNfRnGxMpnNDOEUYrlpAqAVE/slL67nOZUbe0oN+Omy6grDnLbzcJ?=
 =?us-ascii?Q?b98CDU78qnaC4gfpsWeGIoe+Jku5Ne0nVQKO04bKJ5Nf1g8A0YUT74B/OVBl?=
 =?us-ascii?Q?e79LB1umoLgjmHF+7kH0vEjJwAMc1vzu1OXVPdcu8RQMKqvOnfW0ufZNkxnW?=
 =?us-ascii?Q?TxoJT1yy9zTP9EfnJ/FYx/1+sBv92By4oFJrX6EpicVoiIsJx45ndg4KnyVV?=
 =?us-ascii?Q?3FwiF64KIjrXj5bAo/2ANFWOhSm7PvexqllhU+IZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7c1930-cd44-4f55-4f48-08da8410b496
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 07:34:11.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /e7/pnyJ0gVlmUHOtNsk6UmeATeJghA+X91/lJSuAU8UdRByk60jYrr9NMuz82CbwRSTmHCt+VSkrwAzJu8jnLHAy+4udTkltsWHdeYFXQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=892
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220031
X-Proofpoint-GUID: b3cV_Q00HKDU9m6FCMKlyWF5-c3z1wrm
X-Proofpoint-ORIG-GUID: b3cV_Q00HKDU9m6FCMKlyWF5-c3z1wrm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 03:49:35PM +0200, Nam Cao wrote:
> because this function is not used.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>

This patch is fine, but in the future can you please treat the subject
as separate from the commit message.  "because it is not used" is a
sucky commit message.  What is not used?  What are you doing to it?  It
doesn't start with a capital letter.

Here is how your email looks like on lore.

https://lore.kernel.org/all/7ff2d658863db4fd5eecc1a53f682510c2765c3f.1660916523.git.namcaov@gmail.com/

Try to find the subject in the middle of the block of text.  People are
often only going to read the body of the email.

[PATCH v2 1/8] staging: rtl8723bs: remove rtw_odm_dbg_comp_msg()

The rtw_odm_dbg_comp_msg() function is not used.  Delete it.

Signed-off-by:

regards,
dan carpenter

