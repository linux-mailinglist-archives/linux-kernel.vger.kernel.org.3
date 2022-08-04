Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72B589958
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiHDIfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiHDIfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:35:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA06BCB3;
        Thu,  4 Aug 2022 01:35:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2748O58B024360;
        Thu, 4 Aug 2022 08:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=/n16GIF6Tcr7jLyzhsXE5gZnfl5TnD7LS3PWvxaWEaQ=;
 b=ij9u9C6MyBwi3ZuwNyTpHYAFdO1AzRjNe7I4HCcgC2TV6E18EY+OqbrD7wqTMB1U1Qe2
 ylwBuwTVwixibuvKtXC5dFsytB+xQWXOxSq4fJ+Qt0fjeqYkDuuJgwawa8BBXSDZ4gUV
 KfSA22/4XT4y6cu4vNTX7HvdAuzewkuPz/RGcIlpCa6yX5n6Ylg97ZLGTIUSUn/Zn5t2
 04+PULSBVDeynVpNbmi9tWuD+AfQYPBS686exHYyFUzStMTXyOVpD+uQ84EW/AnZKZLS
 TpByKH92jbdY45qMmQxllf4q+y8UOLhakK+35B3HCh1AEBI9jriLuAR8UzK3K3u6v4AH zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2cbyme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 08:35:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27471BCV000860;
        Thu, 4 Aug 2022 08:35:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57sxtrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 08:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjWnBcvHoEsKdSwYwL4lH6TOWk+yifiOwS2BeNv0KgDU/ddx9qXJtifeCYB0yWgxXPOHaa44yX9vCWC9Rk3nLSDto9Xl4zZWCvLxGd0D/1TcZsusUXP0iAYrbvCj/TmWDwT8PCSb1aPf0dg6e4oCeVDSrNO4cUwflTtSQdD1d5T9lhbrscbcKCwjIsF9dRKff2tr3XvzYha6HheQBAZjbJKVRdL+a/23nhdnLCV3nNVFRi0XKpJ4+4NgMP8JW3ojn/+hV1HxOz9q2kiYH/YwQ+0qGPg6bOzIX0cWmG3V99kr62NZ0ngRwLkj2v4cKaqtDuJqyDaiq7ktNLsLZ9Bwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n16GIF6Tcr7jLyzhsXE5gZnfl5TnD7LS3PWvxaWEaQ=;
 b=Ek6IcGGKIOFgIxY035j4/D+SRs7NiDB+VQKFL6ggrWlDv3/SgKdZRDkX1Rqqn74sM0WnZ/DB4uYmXyqnDTJkmQu8bnxB7Y+UF66dEa82dfPVIZebfRqa8+nQUdkc526NRxnah15+/RF8XUvuHj0gUuY0Fo8KFAhP/n4jSvM8fsC0J2Qqyot24c56SXlHe14TBmXAVOl7qAcUx5vP6lFRuLxI9vDgC22fJKicglW3LKF07Q04VfNi5kvEYc2QK1R4RlK/GFlUVEUUPw3mvWSr4ylam8Qx1/af0zxyN5xHoA7o20it42KOzcSmScNdB4U6tDkZOhj0bIYioZuzIMHDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n16GIF6Tcr7jLyzhsXE5gZnfl5TnD7LS3PWvxaWEaQ=;
 b=wOF+z1JV9biJ99BgvOn0KMo626sbYYfRqaNQ+s/fNYKSS64SgFhNxZbhkl0qWvFwi97NYUWoS4VlMC3dM7i+0sb80q3GqdqbcnYtT+4m5QreVCcpE0jWABZ0ixwb95EgTdBDhGVzeoopjEd0la4r4TCo2zDFJH1aY3HMB27GjAA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4424.namprd10.prod.outlook.com
 (2603:10b6:510:41::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 08:35:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 08:35:35 +0000
Date:   Thu, 4 Aug 2022 11:35:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] char: mwave: fix return type in ioctl
Message-ID: <20220804083512.GK3460@kadam>
References: <Yutv/mvLNJRgDtOu@kili>
 <CAK8P3a1ychAteScPbzGymM3UOinxY93rVnGeLsLOggmsRCBB+g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1ychAteScPbzGymM3UOinxY93rVnGeLsLOggmsRCBB+g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc231d99-0cf7-4f62-cc92-08da75f44c84
X-MS-TrafficTypeDiagnostic: PH0PR10MB4424:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LslbhiaQ3xdOlomOKFNAdkGH7NUlbrKCgoa4cDlCs2jiv7dOgm+/OG4J/uZ5dt3EckSwcoekysCa2PV0Ilvy5aP8Xqj86+cY4iXUBN2xNpny1nHU5SFICeNaLR8hgYpugTGnRuWvz5vS3CxeAiAtyllA59kBSTpU1Wbu8DQGMnq9YJEYOYZjuE1Kwkwa10hdYWnkHTVTEvV3ceVV9H913S1/3CuLxuhVSwUIwGjOf/vYmdxdweCB4MCpL90wJw9UV66/Hs6BEguIC8rGssBqsmTQ9kL7EynUE36G/shNcMIr7+uTsQmdzwBqdDM3itGpCecHUKq5YHKp0Tm4D8KVfkM2mPZHfGCKVtw+xvz9uC7SSrpvPvaAvxRmWsfRktquWPEMs0NrVaQs9Ds+i8yZlerriTe649T7AhX8ooySQ4qLNQ1/TaTiTMdy/23lWashUl50O0GUCAfDrjYZefk+lnXXID5Bf+EqYpGs/bw51Jpm2IR5o5aDW4fZUHmtTaGj/YHSpSZHH9dbJLy5sKW7nKOAH90DINV423m+rf6gGIBTMN8b/vxvPeAkciGG0AOGoSacthwIy3zQUXN/j0YxH2k2nsz7a7mvfnCX471Nihwvczux2VyCnsSxVmMUbr2wHkjuox0idCbVWE5UREah06LJHRsDkah4G6c/o5Z3Ud4B6jSvj0xNp5BIMUOMo/MDYP0Daby4evAJn2n/yGnLgftdCjbcVndIkhIi6u+05CRvn1vS7hYewx6v6W+VAAIN1KitC5gGGgOKMTusQYDiL77VfBWJcWBjMnkfKJI0a4CYpsZdy/ganp3nSnakh1w+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(39860400002)(136003)(346002)(376002)(41300700001)(6506007)(52116002)(53546011)(9686003)(33656002)(1076003)(2906002)(186003)(26005)(6666004)(86362001)(6512007)(83380400001)(38100700002)(54906003)(33716001)(478600001)(6486002)(316002)(6916009)(66946007)(44832011)(38350700002)(5660300002)(4326008)(66476007)(8676002)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B58QIOV/LLHSNcxqnnEvvkYsOLsQiTUZfPxWzYvUM7U5Kkxt/ZIRLfvj8s5z?=
 =?us-ascii?Q?K7tYFIu687MkMcWBVu0PYcPpBmjTse2P48E0f9/9k/g+1nEL/yZOoBN5niF3?=
 =?us-ascii?Q?ZunvTvcXOs4m+cbn+9uWtc/JBD35ZFN1VMsoM2Qol/3icXzHi6QMw93OuNmO?=
 =?us-ascii?Q?iQywfEFea0epnAnmBVpRyjINKiC9p+gvqbvwTSu08/HxDZknPZVWboJ2nmdn?=
 =?us-ascii?Q?YnPdixfIU65zbYrkxeGB0OfUuZDeU3MQE5VrPkwwhhbTlkkaSSzLA7VyFPt7?=
 =?us-ascii?Q?dcm+UbhdGnvV6NIj4FcIR2iIY5d4ilpNpt3uU+W396mX4MCjWjRlOcmiIcKj?=
 =?us-ascii?Q?ILSqrPVIi7tw/rajYzmb9txN1IDhfXoz5Gx2/peyqz8yr/TIAau+NddLjcUk?=
 =?us-ascii?Q?RCj+H2Q3f+3+1pUksqdlKvsJ2gFnQG40gbxCTW2OZUCTqKOIjL7XeOrtdrj3?=
 =?us-ascii?Q?oOlQs1k9mpkPtvN0PExwQstKt7/++NftnZ0DrxkSGAwbFInFw02AVZsnLBZy?=
 =?us-ascii?Q?HBszQizE77m2qv949WDLDDSXWqNvkCFBvKxpFMCdLQl73TQe2uYcZZsnJsdD?=
 =?us-ascii?Q?x/XxeI69agIHcI4wmhdsdcg/Cs7gUEwY5eiEGvZ+6ifrrPJ+FgUVfdICq7pd?=
 =?us-ascii?Q?DHYvXOcirPApmH9MIcBmVB8/Pk2CLOw28rTQAAoV2acL8ud8GL+DmZnihOFq?=
 =?us-ascii?Q?E8uzrJiMGujR6Tn4OzJENNMVD1au80XZVDsnXhCYz2m875vdCMH7IistWmmg?=
 =?us-ascii?Q?Isp5pn1ayt/nplt8Jzr8ZTAlFBtnLeNZXchnY+xcsycsWiN4ZLAh+FE8VcD1?=
 =?us-ascii?Q?0qOL1fGdAnWPPdaDXtfkPGagd7a7PWqV13Kndk5dNg0iruPbmuyHbo0QYmkS?=
 =?us-ascii?Q?ocMQAIVcAHIAFceMZo5/c/tIMvyqcLSHJV+xZNofa20ygIQHXsnXSyBPSONs?=
 =?us-ascii?Q?m5W06uxRlsPoJWMYdDOh7Tr/vbrv8uuMDx5cwfDwJOLnfMVOo+lVuyjDr1oZ?=
 =?us-ascii?Q?l+EduB7PWySIX8xl+hxzCePwzWFM7srUH/XHplI14QT0/q5l1G5dnvPHfK4V?=
 =?us-ascii?Q?I5oOShgz0htLSEJId10JO/FnA7nkPNVaD5HufdCz58cd7qBSjwJegDUbNfCA?=
 =?us-ascii?Q?CAxgbIZs+8vtZxpxalNVYNoC+fwTmEA2egx5k1GwGumf/y4SchWbxBsqvDX3?=
 =?us-ascii?Q?w0ydE91hAyl5dvudiGFCV2SHG4jOy6pDFtzHRlUCOG/P/qMNN25ZGl+acFOD?=
 =?us-ascii?Q?TBYLVIim7iOLcgkfPeEhPEhCgeZX9whOTrc8U2GEqk16Q5dR+cDVcQbh9UTc?=
 =?us-ascii?Q?DWgDMQCXoxtKEQ9EH8GdIkGLFmffB2XwmCO/CModYV3RcfE/UmemHQ9S81PF?=
 =?us-ascii?Q?O/UH5Dv5f4ASBO/psBtGrSjiKEj0NJ2c/r5qjFrsisppplJ63oZHdLPRLujM?=
 =?us-ascii?Q?i19bCiEvHJjZyqVhnkk8b4t85Xa0Ktze9S+j3RMhkrooVC2NSjvoqyCnDDL/?=
 =?us-ascii?Q?4/NRkKnhI9IPxpeKAmmmyruNGIAKEXqZdKE1wNIuDNpH2CxrE8TDa1xyRuIq?=
 =?us-ascii?Q?BChJEZ9EAF7gIZLo9toPKyw+JNjEQ+hesUDzCCczY0ucXUlS7fkcq5KcqMlV?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc231d99-0cf7-4f62-cc92-08da75f44c84
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 08:35:35.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mq9eLfyDkc1lhioCjBvJ2qhtMZ6ZL66RM9yVHsqy44hpFGTG2MHdFu/QBoMb5J4EKWIhcm3Q/AbaOrCTWxunGR2SwJUMoc58aIwuZbTUohc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040036
X-Proofpoint-GUID: O_hhtKa8NT3Be5eWc1vd_3faFK6CV1H5
X-Proofpoint-ORIG-GUID: O_hhtKa8NT3Be5eWc1vd_3faFK6CV1H5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 10:20:34AM +0200, Arnd Bergmann wrote:
> On Thu, Aug 4, 2022 at 9:06 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > This function is supposed to return zero for success or negative error
> > code on failure.  Unfortunately the "retval" is declared as unsigned int
> > and the function returns type long.  That means that on 64 bit systems
> > it will return positive values on error.
> >
> > Fixes: 909d145f0dec ("mwave: ioctl BKL pushdown")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > The Fixes tag is sort of debatable.  "retval" should have always been
> > declared as an int.  But the BKL change is when the return type for
> > the ioctl changed from int to long, so it's when the bug started to
> > affect user space.
> 
> Nice catch, I wonder how many other drivers I broke in that series.
> Have you gone through my BKL commits from that time period
> to see if any others are affected?

Btw, I meant to thank you for your other email about IRQs.  Thanks!

Yeah.  This is from static analysis.  There aren't many other bugs.
It's a combination of storing error codes in unsigned int and returning
signed long.  The first is kind of a bug even when it doesn't affect
runtime and the second is not a bug but it's sort of rare.

The one thing that might amuse you as history buff is a preserved bug
for API reasons:

arch/x86/kernel/ldt.c
   665  SYSCALL_DEFINE3(modify_ldt, int , func , void __user * , ptr ,
   666                  unsigned long , bytecount)
   667  {
   668          int ret = -ENOSYS;
   669  
   670          switch (func) {
   671          case 0:
   672                  ret = read_ldt(ptr, bytecount);
   673                  break;
   674          case 1:
   675                  ret = write_ldt(ptr, bytecount, 1);
   676                  break;
   677          case 2:
   678                  ret = read_default_ldt(ptr, bytecount);
   679                  break;
   680          case 0x11:
   681                  ret = write_ldt(ptr, bytecount, 0);
   682                  break;
   683          }
   684          /*
   685           * The SYSCALL_DEFINE() macros give us an 'unsigned long'
   686           * return type, but tht ABI for sys_modify_ldt() expects
   687           * 'int'.  This cast gives us an int-sized value in %rax
   688           * for the return code.  The 'unsigned' is necessary so
   689           * the compiler does not try to sign-extend the negative
   690           * return codes into the high half of the register when
   691           * taking the value from int->long.
   692           */
   693          return (unsigned int)ret;
   694  }

regards,
dan carpenter
