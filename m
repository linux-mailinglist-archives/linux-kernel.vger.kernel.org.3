Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBE2581448
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbiGZNgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiGZNgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:36:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B129FFA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:36:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QC5688003579;
        Tue, 26 Jul 2022 13:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=2cvA2BD064cuO4uxqkVwcIFDMXDAcBjQqHwDHh5NG84=;
 b=UVrbi/jXs/AYqeJDgeWHnd3ttXzeBQuEV14F1ifOL4wQ0Kwsaufn85UajxoffXjAn3kw
 0Ws+stww7Yf+8yYtsGhTQV5fKbP9dbij4OfF+4tzYwNuq1Qay4TBjutwdlD/7ghFmEH1
 XrrMZeGqVOQYLFaOGU9uGJLegGOgom9nP76U6zFW5BvErS44fosdCeiQLxg0zcNy2p8a
 W0/TydkDyJdhsOJxqv0W0zUAkqRBRzBo1lOcZhWQwcTBArIKRp5SmgMIHK6nfzH7dz0x
 3TAqS36WLlnTAW7Wd+HtsSXuI1f8mSdWzGObj1ybk4SJJzlQWVabIzYaBQ6DMu9/tk9T fQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9anx5w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 13:36:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QDBt6K023031;
        Tue, 26 Jul 2022 13:36:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5yus46b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 13:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9BgxdE+5S50c7Crx6UuEAFnbnJ2Nooy+MjLa8NOXRnpEj9XuJQ0kgA9MEeivIzHNEqE1TRVDW++8FdQAKTDOBBPBNYG4doJ298vsttEV0xl2eWC5Bs3bDOeyaa+1FDwQ94lkn6XL3+/mE4tpU/CNKvh2sGkPo+OoK8mb5Avz3oMdXazT/vLB4mr4StChFCLIlgp3Lcn6+dA/206HlQUEC/Fyu3E7jNcRcWDDUB+VlnVv4y6r611rmnsprVwVOJvXhwtoNayW8k7+zNIJgG/LvylALoe3YHtPAupXO9/BUtSpsXD0RaF3G/7p6rPYABZlvC8AXfuty4iXBJtcz3Lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cvA2BD064cuO4uxqkVwcIFDMXDAcBjQqHwDHh5NG84=;
 b=bJLUdGaB8iJwCkkzVivBhh0ykvBEFZwbM9QdBf7XWrO9tBjjVta78BeRWItVeVyn8f1lCjjY2kGJN2diG4Yb1QjgG1aHe5uQ9rJF4p6CyPuDTr+bGVm8DnpsX6Yi9Mxg64IIRuJJsnwLXZjfbrswcYvhQJomt60vgGziKnsZpzFtUZyye4LeGOWSMhJCTNtBztUloHDGFajucqzBySsNDihV16u5GU/hpG1U+GOzUYbl6WkC6HDraJDcAKMQexCMR9aQWShsNqGrTsMxgaZZfjEVLu4r8S0o54SvPeZA646SU+85TpPAumOL8/5F2OMvJdehnuxTbbvVIyK/p5gg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cvA2BD064cuO4uxqkVwcIFDMXDAcBjQqHwDHh5NG84=;
 b=yz3R8FNUUxM/aFGyxyhr72Mmh5/NLgjfkIdTvtPoYxV8jP/FcihUnX6RPWyl0qsQacUpTPXCB/ot/pVwZVFTC4wNgGKZH7ro445gas5qRhS9Hwj0GvNuJ2+ZbaivD9Yj/X6s5zbFsDBUH4kElyfcmYvuTHcvRcki/Nqv3CswXHg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1742.namprd10.prod.outlook.com
 (2603:10b6:301:a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 13:36:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 13:36:20 +0000
Date:   Tue, 26 Jul 2022 16:35:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: convert rtw_pwr_wakeup to correct
 error code semantics
Message-ID: <20220726133559.GP2338@kadam>
References: <20220725220745.12739-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725220745.12739-1-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d56ccd58-0aa3-4345-119a-08da6f0bd34a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1742:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oPeLEEq3q6wfLSaGvLXyxQAEAxYlPd/sG1uBEnk/GYe+CJemyBG91F56l3HdEDwdhbtjtTRcaf1p9QALaO5mJ7fWuJ0vo4ZGHIHuqgQoLn0tbOlkNnac6enzFE+ehwUCA+T7Lvp/XGm9MMLyCPnnfXK28v/KrpEsvaWZaOrbNL8acGPMVlyfopV6Cw42beGW0yHu+OsAJtKfBElhP/VVeBPfdvUEa6jVEGfmYTTC8zKp1RvmkprzKwx/3ajZagbwUn/CXXkPTto7iozmmpsWMaU6gcZMk1LY71Xh0plE4Gw8TPT5X1Y9k5g4cTnlmoSsgFDHtsLn/k95wwdv1yDBpaBk4+HpJLnREhASMs3zTpv/4Fq99E847Qt4J+JblCTIreqDcc5T6ly31D6TwrDF5bVnHg5WuHKbqJ3I93C4dD3CfpzNx1RXbCMKo1FbKDysbj9xoTqVCMTJ4vDavUQL+98BBAlnh7cfebCUIo3oeCo8yudhbOrUx0yvDITPoakttQJ04PI/dWD0bJD9Trr6jextIpse4m9dEp2efx5vpsrFreJXhI1aDomuXVjvXIvuQncMNO6jLk7/ZsniazBCQdiuWxC1xmAUjov2N/pQWzk2bfBh9makkfdqhF4XULuitc0vdNiU2HDITxKLlw2UUYkpcSigcNOftdsRoLgZZ4PY3PlROPVnC28SBbAQnd55U3QKVNFbRbRd0tyTG5InrtynJw4bpndALZ0x0CwbXnLww1iIJSQ0aIw5oe2fEBXQPApdDQxvtLQ+YZKNjJ+bWAQ4MMpKoJo0AT+VeXG9WU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(39860400002)(136003)(376002)(366004)(38350700002)(44832011)(5660300002)(478600001)(7416002)(38100700002)(8936002)(2906002)(6486002)(316002)(33656002)(8676002)(6512007)(6506007)(41300700001)(6916009)(33716001)(6666004)(83380400001)(66946007)(86362001)(52116002)(66476007)(4326008)(26005)(9686003)(66556008)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHrbJrEjthpal2HeTcDHDeHaPaRFsQg3Jijj0KNkDPZXhWiUYerwafVQjvxB?=
 =?us-ascii?Q?lKYn3bIjWqKBzTrfq7DR0J+tNQj5eFCVQox+M5PcjN4et69ohzgMRABXL0bp?=
 =?us-ascii?Q?IXbyDBD4zgLJfUA6WUJfieh89bvTI2rnjw2UkZZkUu45WrdVxvNqIdU9mVce?=
 =?us-ascii?Q?xiyQoMDd4meSUEG2MeCQUCH9lOeuRBIpLlpC/au2GafMTyBILWdATKrYIKhd?=
 =?us-ascii?Q?Fc7epvY4d5uMisW3aOjgddq/APy4TKnjmbkLqhF6rv1ZBdjqcFjAu92z4kdC?=
 =?us-ascii?Q?Rcg4Sg5H19TDG6T4QRlmb2SCO9l4A2PXl+CFuKG1txUdFZIPONpMeQgDp/10?=
 =?us-ascii?Q?6v+OQGIpGi26voydxMdr383Lb9OzynPTE2OODD2QyOsixbdhhNedaQ1uPzh1?=
 =?us-ascii?Q?NyxmssCswepNv7DBHIOr/nNGzljZvl68dAvMN1rjHd3b5H2Pa3zGhJRYKT2Q?=
 =?us-ascii?Q?m1SomiRntbouSXGLMPzYpWrtDT1e+klCaZFz7uIaUx9j8sQ434ZWehG3kKcv?=
 =?us-ascii?Q?DWcwUgzvMEXFoF3CFcdLIWPac4qavRr5dBgV6PY4DzzoJEfC3Hix0CYdG84h?=
 =?us-ascii?Q?AV3j98x9IvPUZ3LJQAHb4ooc3HwQmQ8H3rvNKT2JItH7HP6cdZgjDqYlzsTe?=
 =?us-ascii?Q?xGQR4U6R/1pchmrpVDFzAXf+zIf8yktAYbaBMi6i3EJSW1ei/7wyPC73lAWS?=
 =?us-ascii?Q?axFNLj9+I+aPTiP50DLUEUgZySeiYe7y4DtNOfQufwH2Eai+fqXYIzgadzSG?=
 =?us-ascii?Q?V3NIaw3GNQGhIWb8KZp3u2GZ6BCGjDnojK+cdfEVSq18Y7+0UVWt60essGZv?=
 =?us-ascii?Q?TgcfD6ziAoHa3VTt618JgkQuk8OKD3S4a0MCVO9nq+H/HunvBNe4HWody5G5?=
 =?us-ascii?Q?3bwl8vEVJZHar9tuWnd6GkqQj96O/YnlAyR8wfucKdhuSXatOmpVVn/lycc8?=
 =?us-ascii?Q?IWLM13RMy3ngc//SE5SpreBGKOcX0T1toK8liMc40ymeykuEplkA+e5Ye2/f?=
 =?us-ascii?Q?gvf+qKTXvAQAjfzjYoDQop2cIlfbeFxvsPudabDkCzBFVzzWRG3MWYMRmym5?=
 =?us-ascii?Q?pOcLpIhZKewqw22ymAvCSvD0EjkcuQ2pq0T2bJBu8TJguVnJeiNT/4upsKC6?=
 =?us-ascii?Q?vTpab1lCg6MEyFRxgBSgxeTE42l+7T2orSgKjQe23jbpjjM0EUhM2zP/lKMn?=
 =?us-ascii?Q?Rq87CDU+rXX9H7lWcXvZPgNXYcyyGg86Ct7WhSHtOvL69xR2UvTXDCiKmvKj?=
 =?us-ascii?Q?IEtn2A2Luiy46byfeQ8dSHMhqp0zVJsn6+59sC64OIvbXOUsxnUb89H1Ft82?=
 =?us-ascii?Q?uwdZh5YB0QWvfo8F+n5ma9m9irH7ofuejEb/9UTlStMf4uEvUQ5oJWXMau4M?=
 =?us-ascii?Q?SJrioLgMmKrLgcd7+prDW/ORiyPnp6Vcy6Pv2h4xT61WkqFF6T7vsi5tSxEb?=
 =?us-ascii?Q?rhn/CK4WnTE+6dfrkLEYBs0hwD/JMm9BkgQEtAY82YGmPJN6Zyosr+YhqgkA?=
 =?us-ascii?Q?SQJoFm+bqDqOBCRmeMkl92nR7yTvgiSpI2whCEp1Vxt1Q8cNVRHWpE3uyn58?=
 =?us-ascii?Q?bPg5d/tx25AB8M//oYrIYHf+/iXq5SBzowrBjqOm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56ccd58-0aa3-4345-119a-08da6f0bd34a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 13:36:20.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAo/QW9NasRyPQtN+9eViBNU6eifK0YriHH6KMljaQ4Q2JNdD85DU6CqP54R2/xW/BEsn3owaA8vlFqu3vPAJ+6uFS+841xOXebIV/C77jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260051
X-Proofpoint-ORIG-GUID: Hci7YBRxdJK_jKJtPs60XSnJBrTG5V21
X-Proofpoint-GUID: Hci7YBRxdJK_jKJtPs60XSnJBrTG5V21
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:07:45PM +0100, Phillip Potter wrote:
> Convert the rtw_pwr_wakeup function to use 0 on success and an appropriate
> error code on error. For the first failure block where ips_leave is
> invoked, use -ENOMEM as this is the main cause of failure here anyway.
> For the second failure block, use -EBUSY, as it seems the most
> appropriate.
> 
> Finally, within the functions rtw_wx_set_mode, rtw_wx_set_wap,
> rtw_wx_set_scan and rtw_wx_set_essid, pass the error code on from
> rtw_pwr_wakeup as appropriate now that it is converted.
> 
> This gets the driver closer to removal of the non-standard _SUCCESS and
> _FAIL definitions, which are inverted compared to the standard in-kernel
> error code mechanism.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
> 
> Changes from V1: Act on feedback from Dan Carpenter:
> * Try to use more appropriate error codes than -EPERM.
> * Revert the places where existing -1 was converted as they are out of
>   scope.
> * Preserve error codes in places where calling function already uses
>   proper negative semantics, so that they can be passed through to the
>   caller.
> 

This is a much better patch, right?  Everything hangs together better.

There are seven callers which need to be updated and all of them are
updated.

Reviewed-by: Dan Carpenter

