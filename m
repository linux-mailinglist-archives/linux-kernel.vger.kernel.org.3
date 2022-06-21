Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE145553509
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351943AbiFUO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiFUO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:56:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ECD27B26
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:56:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LE15vk023008;
        Tue, 21 Jun 2022 14:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=G8ihXh3XZdh4rpjUTrS1v/NCDkppMrorAvDwu/yilRQ=;
 b=YZlAzWiRVAa0wQUgs8XnpGxBxgjwFWMQWdvU+QZk4M+H5B2P+y1lo975nK4jQtgjf7uG
 2BiaWJX7ZG+fIogG0E9xqVYRsELMmVtSx9Pay3CExVEiX+pBx5PC5qhU67OCIYDc1KX+
 TQ0WsZUNltemxHS7gAIVpFBBCHZPwgGDSPgdLp58J+Qah6xnVqV+ft1EF5fU29pOCeg2
 zYzud5EjlVNHgfUriK4tKg5QGHIybjwhP9o+Xemxzp8fATTBjJiDQP2ketUa83fU9azP
 4nOEs72BM9buKTjNhNfjm4yIq1LOLiftovnI9qvvTUwz8gzcqDi1R+Kj+JNEYR/Ml527 mQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0dunq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 14:55:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LEkgBf011614;
        Tue, 21 Jun 2022 14:55:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5uf2n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 14:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1bv0M+fzu2QmJ624GF6ZshOK2eIJZkoaeVcXZznCxpeM8lBkg7LcLNJBTn7mhtEOqtxrFTEGDpBc90a5F58XvIRW59pHtKPASY9Az0lKS7h+8b9R3NmGAzGq/PEP966DyNpVm3o7DUYil3oAB0f0e6pyZsU2zKRsNpIFQnH/EIpV/cuDIsMq3MN/9J3DZEFnJq4zFQKfvXoepSV7zy6G6xDLIL17Wx/Y5VzZRXGAi+PRVaHoE4mJQYM9R9UXKes8UzzK41bCy3MnMmTn+2MH1b7Fj/v4DD/zsuVpy8h5FgjsotIwdWA9Sbp9c7SxjPZKBaJHMlNWvutzPoTRufxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8ihXh3XZdh4rpjUTrS1v/NCDkppMrorAvDwu/yilRQ=;
 b=DZ9BDEUaj4kJn4EZJC2TR3miJdl9tVsAoMyPEozciLRl9ZJmmyLmWiyPgBewRzToGXBWGjVb7AWn9zomGrlaRudKN8IgbYS2T+Xw8EdYjmLqqexG77BdASPBVS4HpDfDw4m/y2YJUgTPkSk5XYZlNAoIRayx0tE+FSDMStMX/TxiPmmpvZ1AwgPCxMt2HUxINvdH1707fySQNoSZ0vvIurcJaylQ5GBsMi7jlFuyq/M3qNioXsTwfdyw9l6VHoRUBZw9kpxHLXabsxPSu2SvxlYyKHqI28oDKRx+ZXt79Ci7eYxORyJaJGvGJA+DTfTExUglF7Oe6+nAFt6++Zsvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8ihXh3XZdh4rpjUTrS1v/NCDkppMrorAvDwu/yilRQ=;
 b=UblucoKX7vQ57kuJrT3xKGlBgysq5GRskTg8IaMl46M3wRhwh3zXfFiXs15Iv/qfv4qINqKJKT/zLd4PIh1AICWZypR+KqLYU9nMjC5GLZ/Xqqw8pyr5D9dfgQdfVdyFdE1d3Qq8u02IpoWy8abbw8jk7b/peG8v9GIolzE3Bkc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4411.namprd10.prod.outlook.com
 (2603:10b6:806:116::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 14:55:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Tue, 21 Jun 2022
 14:55:44 +0000
Date:   Tue, 21 Jun 2022 17:55:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     vireshk@kernel.org, Johan Hovold <johan@kernel.org>,
        elder@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unitialized Variable and Null Pointer Dereference bug in
 gb_bootrom_get_firmware
Message-ID: <20220621145523.GJ16517@kadam>
References: <CAD-N9QVVKUDFKMSxUc-smcz0B_7PrjN3DPku+cDM3ZKDn0XLBA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QVVKUDFKMSxUc-smcz0B_7PrjN3DPku+cDM3ZKDn0XLBA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f045f56e-493c-475b-91df-08da53961e3c
X-MS-TrafficTypeDiagnostic: SA2PR10MB4411:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB441174C9230A905DE1C22EA78EB39@SA2PR10MB4411.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBSnRuudwYGZ4snFytLEeWEIkOOuL5OaVEvTgCQvQFbxobLJrV8svsA4JLDHHBN+g1vQ0XLHONt0b3/KRYX9YNWymjrCCCMUCnAiN52P4alLwZ8aGTausYGCixEtiOiJfVmUQ2I/+cNkDH/xXcrh5BnjnkaVtLJm4sOQZ043qdzuZanZXYzjYd1poEF1eqyGkDnjAEEXbwA9RjfDWk/1sVIIHqSSaLsFT3jRn9bLCuzuDGg20ixdtwn+PJWnV1fN3nt7eEgGMoqsQX59MA3I9Dj8r4RMkEDXh5FjCSotZEDqKF3Mgmp02PFSwAovHo1T5D1sSh8VXXvhZT2FSUXBvuDgNZuqYKCPECbzgMC8rgu6xQ0KS8DL1jQ4QXhqo9pidKDmWq5c93ALWOcAq17aaknhAceZipmvNMaLX+PoididXchaopJgYizRQAHgaLPGp4Mpm6xCS6+48/jV527r1XA3jIzSrjHwYRPYTeQSgFzdhpisGcHeanvqrtV4JKnyWbP0/Lk6V9/aGAs8B9DeOIG/jh9WW0E+9ZFRKtDJp8574pxv4kCGsByf8l/NW4vBOe7HjNVb5/M5EAirC7Tde0OnhwGr6qUnXW2Jc02TPYUImSWVEk0bjk8t6MwRpto5DYH/S0g0R67+m0vd1qoEKPCGvfEtiYqhJsiPcy72QR8ENWka5N/lcxHYMe9V5uSqQqlIBtH3tOChYG9Rm4BQXeCc0r5rqUuORuYPcr7bVntBUi1abmsQQevz5tf04+TUr5QCI1KxfbSZn6CjWP4zWsZejketRs5LiFZGkP/nyvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(396003)(136003)(346002)(39860400002)(186003)(26005)(52116002)(9686003)(66556008)(6666004)(6506007)(54906003)(41300700001)(1076003)(6512007)(38100700002)(83380400001)(38350700002)(966005)(4326008)(33656002)(8676002)(86362001)(8936002)(33716001)(6486002)(316002)(2906002)(5660300002)(6916009)(44832011)(66476007)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fwe6H46XJeIVWbH+C3LktEhvYkGxsLwRQWrq/p4UmPHIzeyMpURxHcLP79n1?=
 =?us-ascii?Q?pfCV58e88DWUoWm9FE43Pc5PW5bN56i8rqHceAZP8L/gZy+q454WqTDfRz60?=
 =?us-ascii?Q?qpVmIjnXK/LSck9Q/7Gpcj8GSo1kuiW0xjNE8H+zkRollz3fbxH6mff6Rldm?=
 =?us-ascii?Q?91JGeO5l5aR4OLnYbVZDB67olTFnKjHdITnbQNlUDEtgUONUR88aZ3ypKV6E?=
 =?us-ascii?Q?I2VBUcas8Yv408G0L8K8oWtuBdstsygWQEC8RvXDzxvq6VcHLHslNUjnshr+?=
 =?us-ascii?Q?m4mMmzZpKnC0HGzS+wE9UdCCOavq8JODEK1w+DbGpzjIAQHFax6cZJYgnoOs?=
 =?us-ascii?Q?yTGmQwCsH65Oj0n9KVPDJAOCYjjuTnga1zv64JvnAs7vuDcm3cMpj4V3+jql?=
 =?us-ascii?Q?BfYQtDZ6XqY6gHdNoLDGIl9CHaC/SEliuj+QrDF3ptb/iax6VP/de6d62BGl?=
 =?us-ascii?Q?kPz/eF1Noxkc78QGpuPnAncXCr/xxsN3UL2FHLktEi/wkntbsy6DjxKHtzei?=
 =?us-ascii?Q?ii6uIwSTAm8tX8zkWJN4zWIwhqHumiUkVVxp2CCHfo4kOTkKyGQnzbOasQ+R?=
 =?us-ascii?Q?Gw6qseICcaL5g9Az5i23Vkv1IhrRfkKccOnTx6Uv7igOfvihKowy4aIH3gjl?=
 =?us-ascii?Q?B3PUUFQ0E6lt9krXiXq62JJlbbw1yJtS7nnqnoEfRLpNZDOK3foZc8pz8D8e?=
 =?us-ascii?Q?LGKjQnLiTsie85EidMgRHDfimbjsQZoFZOvbxHjLwzGsMJ/lCEMOQDNfpATy?=
 =?us-ascii?Q?qcRuBCDqu0x7MMxuWRS3K41phaSBSGWF/gtj/YTl7/WHxsRvvBI7tO8BsfhN?=
 =?us-ascii?Q?s5KANfScQO8T5987ICCAWHzW+mtq64qvf4IaWHdhMwPLJSYzvmcz0sMqdJHG?=
 =?us-ascii?Q?wKQFYOnLkfZJV21OPQvW9QdPc0R7G+nppxe0HOD8AaxavOK4SrfQPABDNzXE?=
 =?us-ascii?Q?0tPA8AszS7D5EhcZmj6/yRuQgal8X2Dc30Sv1n35bGRf8nsrPH8zbjj9mV/t?=
 =?us-ascii?Q?mpmtKT0F+1KDBnT9echyXyYaN6Rq3gtr2zLaRVn2ttmzgzhDskzm/egWPCmP?=
 =?us-ascii?Q?w66QE104WXUNWl1LffEZlc27sHyX0OucDJiVngqEhu0ZBpkPViTsPii+TrnU?=
 =?us-ascii?Q?DFmgfNfgbnp9BLpJtQCzNgSmpGWKfp1mGFohzPs8ruZnskxCruJSr0/WnXL5?=
 =?us-ascii?Q?cth60cY57WkrFidQiGfO7OP4MmO3yUJKh6J8iD36SJaNEj6HF/Jvw5L+zNd2?=
 =?us-ascii?Q?Ejc3yRLDj4y+yWr5JqxH07F+l7w+84rttLW+/alrO38ODR/9+evBCA77pTrY?=
 =?us-ascii?Q?kwTzR9WprBgGfV+gZplnP389wFOkuBdM4+S0XHFOzBAoI2e5D8ufXKHkcbii?=
 =?us-ascii?Q?39gzl9hodZuMXuQJyLWjLnv5HqVa7rRw6AkxwaTYMgcEcdhxMrkhH0sy7tDb?=
 =?us-ascii?Q?jj100ovwl22qdH7a6QShSgJq/DUwqCR9C1uM8DSdJNiev1M/HJrBEiYitiE7?=
 =?us-ascii?Q?lszG4M8Niaud9JQCn39dKauvoq54nT26/HmB/EsbsK19HwEggnvjU1c9J5Zh?=
 =?us-ascii?Q?h+omuaV+W2Kxt+lk90Ng7XkL9+XwNnI5yhGX7EkZHwx+PCuDqlNEK4gZyviK?=
 =?us-ascii?Q?ykcIpw5kF8klr5eNjBHEydWec5ixReGT39Ox8UCLsHEL/NLaZ9VoY1N3frtg?=
 =?us-ascii?Q?CdPJF8Zj/rBd8e/rDEcc94szxfWXFBMYOF/Q2nHoLFO5YsBVoRp/+QYfEZI/?=
 =?us-ascii?Q?RIPj8KSY0V4k83++8MQ+9IdRoaBiRVU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f045f56e-493c-475b-91df-08da53961e3c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 14:55:44.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +I4UN/P8bQpSBsTyxhmKcejzmkufAbxsII7XWG27ripBi6IyUDACF3HQyf7SgV0pT34vp7iErIMCRY8V/iC1JGwmlTiSsu1aZsF531TJJuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4411
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_07:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210064
X-Proofpoint-ORIG-GUID: HdioOnX-60M0k0imqwQ_px4xKQUQdiv2
X-Proofpoint-GUID: HdioOnX-60M0k0imqwQ_px4xKQUQdiv2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:36:04PM +0800, Dongliang Mu wrote:
> Hi maintainers,
> 
> I would like to send one bug report.
> 
> In gb_bootrom_get_firmware, if the first branch is satisfied, it will
> go to queue_work, leading to the dereference of uninitialized const
> variable "fw". If the second branch is satisfied, it will go to unlock
> with fw as NULL pointer, leading to a NULL Pointer Dereference.
> 
> The Fixes commit should be [1], introducing the dereference of "fw" in
> the error handling code.
> 
> I am not sure how to fix this bug. Any comment on removing the
> dereference of fw?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a4293e1d4e6416477976ee3bd248589d3fc4bb19

No, there is no bug there.  It is a static checker false positive.

When you are reporting static checker warnings then please at least
mention it is from static analsysis so we can know what we are dealing
with.

Here is the code.

drivers/staging/greybus/bootrom.c
   241  static int gb_bootrom_get_firmware(struct gb_operation *op)
   242  {
   243          struct gb_bootrom *bootrom = gb_connection_get_data(op->connection);
   244          const struct firmware *fw;
                                      ^^^


   245          struct gb_bootrom_get_firmware_request *firmware_request;
   246          struct gb_bootrom_get_firmware_response *firmware_response;
   247          struct device *dev = &op->connection->bundle->dev;
   248          unsigned int offset, size;
   249          enum next_request_type next_request;
   250          int ret = 0;
   251  
   252          /* Disable timeouts */
   253          gb_bootrom_cancel_timeout(bootrom);
   254  
   255          if (op->request->payload_size != sizeof(*firmware_request)) {
   256                  dev_err(dev, "%s: Illegal size of get firmware request (%zu %zu)\n",
   257                          __func__, op->request->payload_size,
   258                          sizeof(*firmware_request));
   259                  ret = -EINVAL;
   260                  goto queue_work;

"ret" is -EINVAL.  "fw" is uninitialized.

   261          }
   262  
   263          mutex_lock(&bootrom->mutex);
   264  
   265          fw = bootrom->fw;
   266          if (!fw) {
   267                  dev_err(dev, "%s: firmware not available\n", __func__);
   268                  ret = -EINVAL;
   269                  goto unlock;

"ret" is -EINVAL.  "fw" is NULL.

   270          }
   271  

For the rest "fw" is valid.

   272          firmware_request = op->request->payload;
   273          offset = le32_to_cpu(firmware_request->offset);
   274          size = le32_to_cpu(firmware_request->size);
   275  
   276          if (offset >= fw->size || size > fw->size - offset) {
   277                  dev_warn(dev, "bad firmware request (offs = %u, size = %u)\n",
   278                           offset, size);
   279                  ret = -EINVAL;
   280                  goto unlock;
   281          }
   282  
   283          if (!gb_operation_response_alloc(op, sizeof(*firmware_response) + size,
   284                                           GFP_KERNEL)) {
   285                  dev_err(dev, "%s: error allocating response\n", __func__);
   286                  ret = -ENOMEM;
   287                  goto unlock;
   288          }
   289  
   290          firmware_response = op->response->payload;
   291          memcpy(firmware_response->data, fw->data + offset, size);
   292  
   293          dev_dbg(dev, "responding with firmware (offs = %u, size = %u)\n",
   294                  offset, size);
   295  
   296  unlock:
   297          mutex_unlock(&bootrom->mutex);
   298  
   299  queue_work:
   300          /* Refresh timeout */
   301          if (!ret && (offset + size == fw->size))
                    ^^^^^
The "!ret" is only true when "fw" is valid.


   302                  next_request = NEXT_REQ_READY_TO_BOOT;
   303          else
   304                  next_request = NEXT_REQ_GET_FIRMWARE;
   305  
   306          gb_bootrom_set_timeout(bootrom, next_request, NEXT_REQ_TIMEOUT_MS);
   307  
   308          return ret;
   309  }

regards,
dan carpenter

