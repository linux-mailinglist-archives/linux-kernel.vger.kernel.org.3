Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264A85981F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbiHRLHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiHRLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:07:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C7A0601
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:07:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IAiCvM010627;
        Thu, 18 Aug 2022 11:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=EhiFHNbPV2tShtDN9aAvu+Hlm8gm/gqZFonRp9TdoQk=;
 b=oDw8O9Ae73j1v4fPG0gWzd1oyDE1GgoQjPslDjpp6puuMtnChRfpq56xioeYGTDsPPtg
 8ICPERHNu/BfREOakAOrNMaclqi1lR/V9qMk93ga/T83l1ogL7LjaY8n1KMb+hKaXt3S
 PzmolYPjzKkZtby10WNjYBrqk9LrYJILJMnPKFubuLVeLpCKS9vjSBFAao6EwPevz8Bx
 iCyQEHV0o7FGm9CgA6YTMpYBIDPNOBT6NbAcoexCv/IEPzDdwiNMT+GVubHGV+5xnSGA
 s70UFBtWGsDfpybSJJ3tlQDJ4vQaUBKKk0li03Bj5kxeiaam7cIylNUqYJoylpSCN7RQ 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1kstr2bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 11:06:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27IAXqtR009965;
        Thu, 18 Aug 2022 11:06:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c2bx2gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 11:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYCfE9HBGIVKKKuFbVALiWnolfH+s5YbjLUmLqVspOoPFXVryFSjmusOwflrel3/WuCQEEz60jl4Ev64aBIdykzGhS56D7m9Whn6Zt3D/CX99Sh0Lw2D966N57pfqIh12sbmRj51JBly8UZS/FZnBqyBcM34sE/femMXslUWgmbcnNB/Zt9iAM+5le4CJahhKPiG+4JlyOyC4C2fstltKKoA8lYMQ0N+gjmALsZ6v2VdkL1HF8jOSE42i/7lTr6xrMkPany9J4ArHFYVv5vA3B0l1O/mXBybr5Xl3Tq2P3OgEkczFX3rQG9gyhSVO/cZ/Qf4EyvaHfvtR4Nr8J21gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhiFHNbPV2tShtDN9aAvu+Hlm8gm/gqZFonRp9TdoQk=;
 b=bkfxT4rT80JZ4gkGTMWHo2HtLFqP3lOr6xtXDimVTcHGZGOlxHwdt9FLRCmOnbjltp3qZp8S7iXfv9tNn7QsKESI3b6QketcbILYTTqwkiWXulHMpaizrxSYJht9Ttjm6+6HLlXo//es2We2SbphlpDvnXX7VOvZn6K2AyASqqC8YyDWd1rBI77hjDlh/B/WGTpiqyEIm1l6fiRdROgfpEDq0qt913SIZeo8wj17t5oO90g/mdM8Qn63nR/cKGpK9HL4wasof60Jwptkq/w0iofNzMQm+giyOd+uS45pwMDEPGmXuMmHWE9xz7kUSfGCA/wni9QlvzO/YpAfs+q3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhiFHNbPV2tShtDN9aAvu+Hlm8gm/gqZFonRp9TdoQk=;
 b=Jxb3s6wovEpGhl2zEyGzQ3DAcj46JarAVVLnDzp+/86CzeAzjjE+aXZ9J4mVy0bbUMjZpxwy0Sk8iMOiWYyPWwqskFf+jkLUbrXiJZumiIsupEXtNxf5psBqSPtMsc+GnVMsMVKgRW4qVmflzfipluNfm8wcaVqU/k41Df2AeYA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3763.namprd10.prod.outlook.com
 (2603:10b6:a03:1f5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 11:06:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 11:06:20 +0000
Date:   Thu, 18 Aug 2022 14:05:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Alvin Lee <Alvin.Lee2@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Samson Tam <Samson.Tam@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:395
 dc_stream_set_cursor_position() warn: variable dereferenced before check
 'stream' (see line 392)
Message-ID: <202208171701.gFan3WQE-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0113.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::29) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad604c88-97fd-4a5f-52d4-08da8109ae4d
X-MS-TrafficTypeDiagnostic: BY5PR10MB3763:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xjm95VeuXB569qiJ9xmR7Kk45BWPC9xjmeJ97oll0OI5K3kbBPBXQsetEGZ+a21k1PYclJ3itKaiBIwD6Eh5ZrLf2koXaYPAX4mXdy2j9+4kxNCT5rQGoVuRa97H6JCsYkSZBlhkAdZkrILsb/Ihu0zAMfuSM1mLiC/oRQkb5zotaSl/DpihTs4eta7OaTtaln05GGkml+U/+zknhdbG2iDa+J5PlRFve0BgR3ZO0LstV3+Lmy9ez21zja4bxRKLkBzFkr9KF69B/dIIYoVogurJ0yZJYaYRagHJbJySdcOvpDzAEn6quycT7Zio5oCjmhuGVs4A3Ccm/eSPpzRHjEQlk0Er+DEnS64z4Q/x779ZeNrkgbalF7a47VELyUiggQ85I8oJUY1RqSA8Ogc+4E8PY4ToIYhbHmaZbsOT2fJ8cmN5IiJGZ9Fub7VaM3LdzzhGXcYjw7GGS/gmndLo+MK9iqUMPa1X0kAnBgD7MIwmM5g8q+V8kaz9g3w9XoiIk1vaMULKqdjMm0eQk5FxxRg4xvRR2As9R0eQsN4uTw+xe1w2fUpY2hl+4sylFoJcx05eqpOI/uwVtC8ucKdRQ5IQ4NbQJFXFy8RvCnrLdTOsBPS8V976i7Gbw4UD5gEIDICtSUOD6bcptZvQEld4tIJQwImrDUnJnl9asAqXUaw6rkE5OcH2ga7fYxmLUuh1cRsVRGkQfOIKuYOfre8ogwrD6fua1gJCEoAB46rJFxn/bUXncQVK+FZD9XjsEYoRnKKZdosqAq3Gfj2IsBgIRZZZpxqm1T6zxNujH7frUDwGhczvapgH/suzP9XZ53FyLw57wSC1sErlN2Fo2M+tqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(366004)(396003)(376002)(6506007)(38100700002)(38350700002)(52116002)(41300700001)(6666004)(186003)(1076003)(6916009)(44832011)(36756003)(2906002)(54906003)(4001150100001)(5660300002)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(6512007)(316002)(86362001)(83380400001)(26005)(9686003)(966005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GEl08uqQ9JxuZ6uKPFjxGhEukxDly18MQfWF+2iL+ILKUBIcApNziPxM6kxV?=
 =?us-ascii?Q?m+2FShJ93gyRjl+WpA05AajMumkKbZAtBhsj9LkQzN1NklrL/doDm80bdMw7?=
 =?us-ascii?Q?jdXfDzfQcX2fZ9W9B4G4TVs0m20assFoKFrRMdH7aid4vhHRx7BYZBqgXTGg?=
 =?us-ascii?Q?VPNRsbNnZLwbqsTidV4wNfX4WODD+QnSG3mYcfrD9PepEYTNbi9iUWs/5PBl?=
 =?us-ascii?Q?oycZuEr3K9B2AeY2cN7DdvdzF3Dw2rYekDvZfFZWcoVHdP4Tvot3NvRJV3uo?=
 =?us-ascii?Q?TpwDCz5SCmdXnuFAb0Bne5PT+FnRWkTdRfib45W8BVvBUqDJu5AkVcg2MPjR?=
 =?us-ascii?Q?BYz3GJ5dJ6ip4xKn5jOLJQbfSerDQJcBNqItiw47fkA8BGkf2mZtZNSxw3hL?=
 =?us-ascii?Q?uK5fYVFAcAFHHpmr7XmmuiXnwE0yhW2sla+79zSb8SlvuPF9lil0XYsiPoE9?=
 =?us-ascii?Q?Ug25yAf9XSURNM0Vwa3DOwgwu4vbmSDQZLMee+czIS3/s9Y1/8w0VABn+oep?=
 =?us-ascii?Q?S07rRPz16gIki36iPvUYvo81psQNJTdzXvsUmELIllUbfOYFrELwQZEu1TSG?=
 =?us-ascii?Q?0Q07+wcmIdM5MFcdgA2V1b9VgI46f0uruqwHHyHI7f2wB5gbgUl5lblyEH/f?=
 =?us-ascii?Q?4IfDDJjn53GihzER3n1UiEHsmeUXoU8G26TPp8ijZquAm6VRMJ6Vc/OHQCLe?=
 =?us-ascii?Q?6yVXFW6EHs8ssrCx926Rm9Xx0CXuR3fxPlLE37augv06ovM9FBNie2bkCDkP?=
 =?us-ascii?Q?TMp9igQrgKRoJMbA2TYMrSUaUTX+djckjYXKxwZCtHVUj9gOFdmX1PDOWDaP?=
 =?us-ascii?Q?tP75W0ChoOA9VbXH5rr//ZN4/mmn6FS5kaFVEc2vONKRvfzJ4qNs8soLH0bq?=
 =?us-ascii?Q?mEXHGXJ0RIqOvfyN8OU66+Vt441D1VOW8oMcvo+x7+OpzHWYtiDNH4K5rfs3?=
 =?us-ascii?Q?Cf/kZaORzH49+dPdyxQx5VUPCGAh3VX71oT/LaOpcmel8Kdd4biz1ADkANKo?=
 =?us-ascii?Q?TQSZ5sfchRfvAtMCQadN89B8h+GqdAQMYSQvFD10SQvdSYrBP9NHT3BUH5S5?=
 =?us-ascii?Q?a7RiFO2TQcMrQEtbmyXKdF+Qpvz/GXF7UYGVgcAz+drjzFPGftxoom6AesnN?=
 =?us-ascii?Q?jpAwqEJDyptmNwerky31yTKqivWzZBDTnejz8gWGkQIawAFthuCHrn+Qt7kx?=
 =?us-ascii?Q?zHt7yYguympTMSSoPsg6jFb+DJuQIyihsWwfcLBNh6eJ7I87NRLQjar4rbVE?=
 =?us-ascii?Q?e6K3yBnWstNUtQBMUu+cLa8+rqXfufLPFPkiYbrtgvJsBMELCHu70y2mk5uo?=
 =?us-ascii?Q?NVVTZ0Q7PY1RH1dSN6HCNwTaMyUsCnZz4FThjXMh/xOgGedyt5qEekPn7p6Q?=
 =?us-ascii?Q?qqXIqwT7GSmRt6BwREer4HUpQJnYCF5QeOf5bwnNoT9lO2nNRaJrJLNFrSoE?=
 =?us-ascii?Q?tRp6xboU52jW/LFzrAx4n14vQf9+bNbxUaELRowFQP7T7d+KLWe8SgL7YCmA?=
 =?us-ascii?Q?2YyuO/fxLF6ghl0xcd97G9rGPMYlEDaQTVY5U3EOH+E+m3nZBL0u/L9UYkwc?=
 =?us-ascii?Q?Iw1HyaX5wM/SlbVkvnLjaAdgWp2jo0GveEe+KafJ329kkZF/Yd0hT8J8ex+k?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8OvE8e39hIlPWX2YB2tRD1vc2oeao+jObsIcS0h1olsW6XxNc3JO/zpLnaNH?=
 =?us-ascii?Q?BS9PHNt68rC03HPcdD8MZhVZYCERTgv5BmZGLE1PAudbsY1JcNVZwI9BkM0r?=
 =?us-ascii?Q?Oao2aC5YPyRL2B9KLSLa6zRP7uBXiUw5FKU0KtKD8UtlGnciIMA7zAyuLFed?=
 =?us-ascii?Q?x1rJHofle5scWHYIR4AxBf3jf2dn+MWH9O+FH/LVpTBVCYDkXoI6UgapFyM8?=
 =?us-ascii?Q?fAReJ2GYQcoYoeQi1mIgMhvsEkwvYMiWQ6sU1dBaGZI4XQUStfAwC902FeuJ?=
 =?us-ascii?Q?9tQ79sVnRBCT+e5mpTXVemCCg+HRwF2KbZaNfoq7WpOsVUThY53FN8j4xH/v?=
 =?us-ascii?Q?LlonhGL+MF97s6Z+jQNxUMIGv5h+oIqji1wBawQkS2guBaOqH0z675OXrNlK?=
 =?us-ascii?Q?yQvymv42TC/hkvLubtaGqqr87JY0lWs7XMrNs/ePlUsm21YS+RCSg+NMNAsA?=
 =?us-ascii?Q?UtR2bKEnW+ETaE6RgDtVlASGReHUaKT0ztSD9/jdGrmz+OVD1Os4M5/3qTSJ?=
 =?us-ascii?Q?KJ6iG359paajLBZpdcvnRyAFqqbZ3w1p0jJaM3HL7lfDj+CdrvdBlt1RpW/8?=
 =?us-ascii?Q?hjG/6rzmgOjvz7FaZm5ZnJJjZy8uD9fzrOrwuEVFJQQP+xJmZu35V1LNm4cW?=
 =?us-ascii?Q?q+huQWhoJge3r6ydJ/KXRj5TGvQG1NLA5D8S4TePc/q9veUILGwjhJvllVer?=
 =?us-ascii?Q?ACTgwVn5lESqnXDNXsmhtYeTuaOm0pH41Grb10y4/f5neYr6VX1DViDeV/W1?=
 =?us-ascii?Q?1yhONZ/Ug/7jmaOOqf/+YJOKT1RhNQY5c6bmlVbb6xH6c7LZwi0uP2hhByWF?=
 =?us-ascii?Q?80icmOHFUra2uEwIeMMaJFe+gKCnofwSG/gC1yUNZdCYd3WL5dA2/eJ4Atso?=
 =?us-ascii?Q?WTe1t+zY3Bc16Hcueg+d9GJoX6B4NGSlt9Ntjb+LfNoq+LMl5Ak5BjX0kWed?=
 =?us-ascii?Q?VDfYbcZxx7UKspmsUYA/4C+AFaCug/U7NghbKhYBMKo9QxZIWCHZymadMv5d?=
 =?us-ascii?Q?0KK1eQkcqwIKb+lZ0v8yOjUe+hSYfleA3wxKPOFtNHjgYr4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad604c88-97fd-4a5f-52d4-08da8109ae4d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 11:06:20.6588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdaaPFXZPnsn4fHXZdg3zw919ay/uBafekWzlCTlkL16F/6GSosqfsiQs/ukQ+G2ysVQi6ubSRNC2a31+sn50QsEMj1Erw4fz8tbvAXB0rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180038
X-Proofpoint-GUID: L3PmQWbhrLrud3U64nA8zZg2Gi-aiLH2
X-Proofpoint-ORIG-GUID: L3PmQWbhrLrud3U64nA8zZg2Gi-aiLH2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3cc40a443a04d52b0c95255dce264068b01e9bfe
commit: a141d2083b462505727e14d98db5fc3cd43d59c6 drm/amd/display: Add debug option for exiting idle optimizations on cursor updates
config: ia64-randconfig-m031-20220814 (https://download.01.org/0day-ci/archive/20220817/202208171701.gFan3WQE-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:395 dc_stream_set_cursor_position() warn: variable dereferenced before check 'stream' (see line 392)

vim +/stream +395 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c

ab2541b6739508 Aric Cyr            2016-12-29  388  bool dc_stream_set_cursor_position(
0971c40e180696 Harry Wentland      2017-07-27  389  	struct dc_stream_state *stream,
beb16b6a0f921f Dmytro Laktyushkin  2017-04-21  390  	const struct dc_cursor_position *position)
ab2541b6739508 Aric Cyr            2016-12-29  391  {
a141d2083b4625 Alvin Lee           2022-06-03 @392  	struct dc  *dc = stream->ctx->dc;
                                                                         ^^^^^^^^^^^
Dereference

4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  393  	bool reset_idle_optimizations = false;
ab2541b6739508 Aric Cyr            2016-12-29  394  
4fa086b9b66408 Leo (Sunpeng  Li    2017-07-25 @395) 	if (NULL == stream) {
                                                            ^^^^^^^^^^^^^^^
NULL check too late.  Presumably it can be deleted.

ab2541b6739508 Aric Cyr            2016-12-29  396  		dm_error("DC: dc_stream is NULL!\n");
ab2541b6739508 Aric Cyr            2016-12-29  397  		return false;
ab2541b6739508 Aric Cyr            2016-12-29  398  	}
ab2541b6739508 Aric Cyr            2016-12-29  399  
ab2541b6739508 Aric Cyr            2016-12-29  400  	if (NULL == position) {
ab2541b6739508 Aric Cyr            2016-12-29  401  		dm_error("DC: cursor position is NULL!\n");
ab2541b6739508 Aric Cyr            2016-12-29  402  		return false;
ab2541b6739508 Aric Cyr            2016-12-29  403  	}
ab2541b6739508 Aric Cyr            2016-12-29  404  
2b77dcc5e5aa38 Anthony Koo         2019-11-05  405  	dc = stream->ctx->dc;
bae1f0b8a5b189 Nicholas Kazlauskas 2021-05-19  406  	dc_z10_restore(dc);
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  407  
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  408  	/* disable idle optimizations if enabling cursor */
a141d2083b4625 Alvin Lee           2022-06-03  409  	if (dc->idle_optimizations_allowed && (!stream->cursor_position.enable || dc->debug.exit_idle_opt_for_cursor_updates)
a141d2083b4625 Alvin Lee           2022-06-03  410  			&& position->enable) {
4b675aad969507 Joshua Aberback     2020-08-31  411  		dc_allow_idle_optimizations(dc, false);
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  412  		reset_idle_optimizations = true;
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  413  	}
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  414  
33fd17d9125c00 Eric Yang           2018-01-18  415  	stream->cursor_position = *position;
ab2541b6739508 Aric Cyr            2016-12-29  416  
4fd771ea441ed9 Roy Chan            2021-07-19  417  	program_cursor_position(dc, stream, position);
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  418  	/* re-enable idle optimizations if necessary */
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  419  	if (reset_idle_optimizations)
4b675aad969507 Joshua Aberback     2020-08-31  420  		dc_allow_idle_optimizations(dc, true);
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  421  
beb16b6a0f921f Dmytro Laktyushkin  2017-04-21  422  	return true;
ab2541b6739508 Aric Cyr            2016-12-29  423  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

