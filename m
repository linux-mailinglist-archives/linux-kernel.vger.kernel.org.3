Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388DF5866C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiHAJSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiHAJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:18:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A82E1A04E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:18:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2717MmMa027979;
        Mon, 1 Aug 2022 09:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=unZfjI9lewjUXqyurRfKekFrpjmoTdz0rHis12sszVo=;
 b=APfth+c0sIktTS2F2wKAErr4ujrhebAn8MNrVz6pc5O60AY8vU1ppI4/Cu1b8mgkM/U9
 pRRiIsWpOfkT8AVT5YW3meXk1SYo+duS1dnV4+MmhtVOlwRY+hwM50yD53x6Ce/vg9tW
 niaVZsFbQ+CL9N1wWWhz38YYNfgri0ZNAHHnQBat1lfY5RPyaiAbA8Sj2MfTgRFB1Z1z
 Wz4DaKyr46fenfSr/JY3tgBYIDvgh3EVl34rC0ZegBBxBSk/BWT31Yyu9n3Xhr9VZfgR
 zOGpZjs0OgEfMCefSftfPJnPQt9kUNEloESZTBz6cvBlDQwehQ0al1Jb/4ZmoOpRSNwK 2A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tb374-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 09:18:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2719DalE010963;
        Mon, 1 Aug 2022 09:18:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu312usu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 09:18:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d619+od/sxkUQODLQ3i2G0wrTca2Gu74pOs1s2I8XeI3eFORM2F6GomHuBKJ6vwIV2gxhiCiunuti62mpB4G7togbd8a4Kb5qJJS7esM7GZ4VSLNoz3Bwd/KjJgSJdTrUfpbpBY3yoodJMgKZY/Vs3VEpyiy1Q+erAct5uD/enHi0/GUhY0mWza/Uj5uYNEs8idsiLhFcPGfKlPyovUYRBJG3n7X41u62Fj3uZQaMMS0qk0pw5fOUrEK3h7HvviOvWnhpyjT+wOJLveZieCv78UVncP4sjfvIPSVabWC/O/u4iUS04f3kSyv8JrEWLWdSo3WQweiaZoaSu6bTosFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unZfjI9lewjUXqyurRfKekFrpjmoTdz0rHis12sszVo=;
 b=Nqix6C+em2UMa2CN559To2QlRraTRiuP0VcDX7CZdXD0hcZtrrJ6k1lSLCpvgAXSLbDMJMXH/YIRORi/g/WcL/B7exJSoKpmPxq41QBqREDAccMnbkfkeDTykK8qEd8aWzLfvcH7TTkHzVCaychwgbjXeTHOowCTbUqmB27aW5w+1g3BMAkuWQkKCLQOIbHLlMzUFK4fmb9BMVzKsstDpSC+j7bKkGjlzWXjD8nEhETy6rCxwyxzaDPD5sCDaFFUqYZejaOL1sp7l1d1JhaLdfWuTqOiVG/M8djY3/OPcUaAMcXuHdcBEWJD8SGMtgqySuEEo3NdZajltjBMseZODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unZfjI9lewjUXqyurRfKekFrpjmoTdz0rHis12sszVo=;
 b=stS/aodzYEp/iKOkrpmgWvre32ruD3b2DGXW4ZbJrKZ7VaOpyaBC0czkgn1ed6/Csuly32Buy12KON7744sDun20a6zx52Ntaqo7bJEFCYJogg2xtE7B5JFU4wMoGU2lJvXjPuYhRw2WFizIDeNnZ0KSCZpRvYpbp7eqMf8zW7Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY5PR10MB5961.namprd10.prod.outlook.com
 (2603:10b6:930:2e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 09:18:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 09:18:22 +0000
Date:   Mon, 1 Aug 2022 12:17:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, paskripkin@gmail.com, martin@kaiser.cx,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: r8188eu: convert rtw_set_802_11_add_wep
 error code semantics
Message-ID: <20220801091735.GB3460@kadam>
References: <20220728231150.972-1-phil@philpotter.co.uk>
 <20220728231150.972-3-phil@philpotter.co.uk>
 <20220729064803.GT2338@kadam>
 <YuV452xuR1S0WyJi@OEMBP14.local>
 <f93d3ea32ac04a5edd8159abcb0504f71fe7aee4.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f93d3ea32ac04a5edd8159abcb0504f71fe7aee4.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 046969ee-3dc8-4226-a4f5-08da739ec7d0
X-MS-TrafficTypeDiagnostic: CY5PR10MB5961:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yNHVTu4DKTDm1XdyO7H40JF/d46Smb/yYp4/NvFviNy4h2VCik94aR27YbfjuIXAJKSM+iRIGChmOiZOT/inTqBc8g0tYDNLAM0rcXydIoaoeL5dDxAyxYkqyMD+zynOOhawe/+kqE/A+hp7HdKps0LMuJ9JV4yXPhQ57xSSH4REwp1FcHZAEcAuPsms2Jw9J6mc/MoQEkQVRONu5KKnkQSKphiYoZhA2ya0ulaBOFFhfuAhsgmELY+NAvItn38rLIcoxpxwLURCWRZn5ZfS0d/goGoY8SrhAVwxD7B5dL2UGNwy7lWxsntf53ub2Bil4VNYzpMh/ynYmOnqHOgwFjNLkDazffxVcGuAjhNkmF4oaafc4s+HLrlUyLV8v2BMRJlopM6QgQlsxoZp9oikFQ/VSJN0iduLaY/7rklzu4HjBaV1DrbgOn4v1wUTilV+05wNjqQLT8u/cLGhiGqUQtW3yWL4k1kpT/q9/dgZZrY54YuNV1A1q+xX40zKrs/GJRgQNrFZiRs8eScUFAa3PJZGVVpgs55oQgrywMdb6sR/qjonvu0RLTac1o8Zt3PXBJRD1zpehWABPC0UOtuCHyrlLvSq5oubeSxGmujRYYERSDWpBO4D/JvUVLlEL+C4dqdqw2s5gj5rbAfxy0MJ8nKfy5LKF4frLsBLSAjodKhwd04auHU/4KATTrBSbIc9xjvqt660LtOkEGc0A2mTDrDLd2zDmxGYIYVleh7WXnoZMYP2krZy3zq7ylkunAzf4YUdfTQkDKiniWWjJX+gjvYTLXZbWDs/nc2uvyUIjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(346002)(366004)(396003)(136003)(33716001)(4744005)(38350700002)(38100700002)(9686003)(4326008)(8676002)(66476007)(66556008)(66946007)(6512007)(186003)(86362001)(44832011)(1076003)(2906002)(8936002)(5660300002)(7416002)(6916009)(52116002)(6506007)(478600001)(6486002)(316002)(26005)(6666004)(41300700001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWKSq6sCXNgNe/Ezetxa6lfv86sMX3gZPuZh0ob/DKrYkzqc8/VmvsJsZi9S?=
 =?us-ascii?Q?yhKIS3tbudxh0UeDkqlWaKp8IkcHbmGT5Vr33u6Vp0V6qFm+TZo4IfajVzmc?=
 =?us-ascii?Q?wDFe8BPiJt2140LYqc2V8ILgDGhR/uvZzhVpRgi4njURHYcxDnb4MuQU/ats?=
 =?us-ascii?Q?uOs+24ijhAPw0Q+fJyY2xtqWZOHxAE9VnMacJM2j1daQoPhoI4DVYmRVUGZy?=
 =?us-ascii?Q?0AF/ccpV1QD6cE5n62ni4JlvjOpdImom4h5RIe6iKZuU7wV4MmzFHzGveOUU?=
 =?us-ascii?Q?Hw3PJ0xk5UNBaq7WyozUmvWhY9uxFPtAHPghHN3MrnhnwB0rIo/Ec95r6rcJ?=
 =?us-ascii?Q?u3Y6kozS6PugLRBRZjg+uayXEXcymT51DAZciDDyufc3wDMwu1UmM66a8xM+?=
 =?us-ascii?Q?FRCJFS0UQihaD4pbM/EAUPZ8Qi/NyaO5LXzhSxFJGlA4bmLP9dNXOZhT/M3y?=
 =?us-ascii?Q?kgGrSwnSvBKR3BIMPUKQyhU3b2UBT0QOliZyuPX7PeXFqjeT0clfvWgRznVu?=
 =?us-ascii?Q?kCWIHftAM4+kbv8950PT+lAXw+U7eHQmtdzR/Otahm+6jzJCwEhUamDCzBT7?=
 =?us-ascii?Q?6P2+mxM6gTSlsvdluBoqdlbCRtdyWo8Ff/IUXATvd7PThxOcmGS4duAdr1BJ?=
 =?us-ascii?Q?KELqLn9MIa6/gItbyHMc5tLO0WaeXZwafKWr4ZSZVwHURiHNUGM/aWvEE2x/?=
 =?us-ascii?Q?3KCRCBDWsuk9UzvORVKTjaJPgg4WgsIt2QMqUcObq1uCsN39KnrKrV6gNbWM?=
 =?us-ascii?Q?tHgbqL0J55MH6ZWXIq33Ur7efrvHp3ddd9Q38+WNFdDxk8MYRDWSsQDEzfO3?=
 =?us-ascii?Q?FlZEbN9SZWlzy3Xe6KOzoXgJbXmR5x7vq7pC72HfVvDcxzCHssm6GuivDbQy?=
 =?us-ascii?Q?NvaRBjXjPLXUOCzE+ob+2QO3eVzsKrG+iSw1gHF89XJGReCo0K1B01c9DHHk?=
 =?us-ascii?Q?Pst3yH9XXop46z/SryfYWJNimrWztKF/1JdU2Vfo2tU9wuf5CMHCw4oAsjcX?=
 =?us-ascii?Q?axu3el80jw9BAIV2ggWsoyZllIqpk2Z7vbQD+4UUYZtGbbEuH98VPWwbPjH9?=
 =?us-ascii?Q?8gcrdTN855xdkc4riEscsVrIUkAd+VjHw1+O1dtIoFKnMR0EPxk5OK41zbeV?=
 =?us-ascii?Q?qfUFgbnKGLCXgW9hsM7R5GdXR2elc6q5THn6smFYeg4/DCCactCkf4D/w+Oo?=
 =?us-ascii?Q?BrSWZFYNwGH1T8KV4/9emAKUOgXd+VVCHDFk8TsowCPz0cpJ+oZBEBcJb3OW?=
 =?us-ascii?Q?Xcj7hJJpkloybne2Czqo2rLx1qRVY6ELKuJPYS3gZOQzxnAG23USyKE5/hsU?=
 =?us-ascii?Q?5DrQev/tU7CC0EumklNU0xDNowZz8einNnfY09rLatmjuqmGNQFzsGWH8uz2?=
 =?us-ascii?Q?GhTtgUOQiDhJ+ZHbalLK6Nw5YgWvgWUTS5mAzPzJg2d2e5UZ7ZWPEHz/udDa?=
 =?us-ascii?Q?oRAhOlgb7uGTLtGo8wooEX2wmMOLXLUqlNKjXG92PRlV72t4avRyk/T7y3w1?=
 =?us-ascii?Q?UeEQHQCk57i+gTV/ULnNfUMhmHC6Hu6aBUaCzOMBrD2fx4HUE/gwh2Ht9Kty?=
 =?us-ascii?Q?z1Kwly2+tUEJmDQOFFmEGFRCZjNkfV2+SNl65HJx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046969ee-3dc8-4226-a4f5-08da739ec7d0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 09:18:22.2588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zj5gOoLGRmCULyv8o3fxk3FcN+vZ4RIsyaDFSZSdGuktBDF4k/suFOxkp3tyMQYWxKYm2nr2cgfWBQ8QlKS7XbJyJ+3maBXb2k8ijcciKRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_05,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010044
X-Proofpoint-GUID: EXUDxOheEkxf1W9xCiPkNBTkPcm3b-k3
X-Proofpoint-ORIG-GUID: EXUDxOheEkxf1W9xCiPkNBTkPcm3b-k3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 10:12:56AM -0700, Joe Perches wrote:
> > I'm happy of course to rewrite this to address any concerns, but
> > I was hoping I could clarify what you've said though? Apologies if I've
> > missed it, but how is this function now returning 1 on success? It sets
> > ret to 0 (success) at the start and then sets it to one of two negative
> > error codes depending on what happens. Am I missing something here?
> > (Perfectly possible that I am).
> > 
> > In terms of do nothing gotos, do you mean gotos that just set an error
> > code then jump to the end? If you'd prefer, as the function just returns
> > right after the exit label, I can just return the codes directly and have
> > a 'return 0;' like you say above?
> > 
> > Thanks as always for your insight.
> 
> Yes, you've got it right.
> 
> I think Dan is suggesting something like the below, but
> not necessarily in a single patch:

I always like your style, Joe.

regards,
dan carpenter

