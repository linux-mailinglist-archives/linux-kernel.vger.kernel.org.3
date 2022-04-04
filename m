Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CC94F15FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353941AbiDDNfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiDDNfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:35:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA566165B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:33:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234ATdga004892;
        Mon, 4 Apr 2022 13:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=wfDouJ72bW1sq0jiGSfWN7Hj93tXlBTK4YVsPUZMFjk=;
 b=lMzfCuxqxlEq7zMjrW6vwmpyDLEkWp8JpsyOCfP3wda9OPLc+HmadmrtP1BbD9KNJNw7
 FwhndX/8VwJ0qaNnY2qmUDgvozIpzNcp4PF5GqERPUBub7yfcKD0qCyK61o630U2GEjX
 wZz+7GLQiKYfI8A3sYrroS+tbO5RzAHdg8FdWbfrY4sVQnPE+OliHY5U4SMcJxcubL6y
 p9HH+nFn3oKkUFttxHeXOgEju6W1dLgH+b4NijTDro0bNvlfdARgRqrIw0Q/0dmb5hKB
 JXSQeWYf0WUQx46QWmcyipXF6+IvXxmcxvEHifDiIJKXga2Iw/g9lJFINp/IC8lDVXX7 xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92u6yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 13:33:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234DVlJv040004;
        Mon, 4 Apr 2022 13:33:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2j61d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 13:33:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doxS0qle9r8Q5bQpkj5i5Yk55Osmbob4Wf9292RMe6Z6tToGKai3uAvvt2FbSeMnzDio6gg0TF3M/pfe+5OlYtyUJoQhZGFSaBcRL8m5/Q80rtTDLoWcjH8/kOdJE0gJOssJk2t/D8ONbjWaqp1gsHsy44Ybbu2xbHiqrxDkwJMjCdRke3/EoqPtDkucWSGYjenhcmzVcowYl/C6ia2C0prpxEeNsJHhayjYa+7XDUuPvQnclEuV3EJCErqUoLalOjDFqa93O4xsWE5BjxMG8EPCSzJ5hKbc2SkyDHhYBWYs4fo/Z8qMJVrkEuKqh22lz5E4i+TaTjXcLuf10AaXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfDouJ72bW1sq0jiGSfWN7Hj93tXlBTK4YVsPUZMFjk=;
 b=Tu78y/3GIVEG3hdBFPpyOzS6mHJ5CG+GuMISjkAsTRiNzk9zN2uoENiPliXT6TFzJFzRv1mKXybbm0AF74lVkEFjxaq6v11586fG7wtMBDxwa/H8ZsBdoYodBbX0/IbmyWeD2K4coQC5TUZKD35Tncvy/NWhmzegmUudlroB57OPQEge+7hphA2KyY8o18++4vXEgl/HGoQa5r9s/vYUInHn/psCMePrO6iH9nEJAodpeUNtWAzDTsAjjzlB96hQBDshuSAlbZzYGW7czP8wJ11UGW2YtjBQi8IYVwDyUgJUW2nHIhvrXwQSgmSXqOpHkcQAB4dD+e/VfVryu07oXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfDouJ72bW1sq0jiGSfWN7Hj93tXlBTK4YVsPUZMFjk=;
 b=JfQSnZqyEdnBuxgQTAoqMtlWZDdyugv/D4087ex9SU9i/8VmRtn0OOciXCyFHx7alUtpbvoeJbvBgCvzAS8x9uivW861L8BEJf1fPPc/CYEBBWXv9i6jjzGGyX0AX4fl6s4hvTT3ILx1+aLss4B5jephgeusWkWRBR5/Rdnh8dw=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by MN2PR10MB3968.namprd10.prod.outlook.com
 (2603:10b6:208:1ba::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 13:33:34 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f%7]) with mapi id 15.20.5123.030; Mon, 4 Apr 2022
 13:33:33 +0000
Date:   Mon, 4 Apr 2022 16:33:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Message-ID: <20220404133312.GC3293@kadam>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <bf1137fa-5051-a834-0c1f-042c5a8074a3@gmail.com>
 <1858641.taCxCBeP46@leap>
 <2366209.jE0xQCEvom@leap>
 <617af7b6-eeac-372a-7bbb-828db11a2aa9@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617af7b6-eeac-372a-7bbb-828db11a2aa9@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 404a3c9d-97d3-4a5c-65d8-08da163fb714
X-MS-TrafficTypeDiagnostic: MN2PR10MB3968:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB39689EB3AE6F739BA0DC4E308EE59@MN2PR10MB3968.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6MfzrMY7drlMVGm9IRX2XBduyLSBS6ZBp+X8YNKH+MhnoH9IFx5xSoYyZKZtfUvt92aw1oi6+TK2p6RsmYIdhDMYc6khHXqj0LIjv0eL177LNf8VYX0M+x0OlvjPVaEghzwdkfKAZQZ8Y9sxRCb8mRT3GgIeWJe0qFryldf6x0x6bO+WEv2lYsvO5KcjcpT9j4uzf8m25zusOyZ+jJXoQAwgsyIF7JFeND+qa+zzr1CjFiZN8yrM420SNpbeIJvAfvF67K4hE4tGU65U+lA6UQJKtgs+qwYvg4+dQuxD5Ndy1sb6gTgzw2ZZd+TwxJCkrq/SnF9/ByzzeKdqmGoRleRXWxtVeENIMSDuzhv3lKFHmq3iAbKKauK5qTgb+mcfkuNuiJlBQAgvDhnKUv/jMCIdWwBUnGEY46ccYUm89WzFmdEpvTb13sFClwrAktEJGtWFLx3FetX3Zy0wYdrG6lLO/xt9slzCth8NbXne+OYCmAgI3wH35Y/jgVDAvP3Y4WUjP2QcDU+lnfRD6Y2lrp0BiVi9ICdUhtQdJsfsLS2sWNQkyTWEt4QtNNaOmLU+WiB2zDsYdHlSzTKG6AzqV8gjnzWIIgbVDbvW8LgV7S9q26cQ6Qz6Nf9nK/DuB+lMGlSTSUTRtd4N1hjcVcHTMu4tq8kQQn62piaWEFy7XLEBjZkp/ZXzD1Z+7zXqHETSr0ZKzWEDxySK4pQLWEyQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(66476007)(54906003)(6666004)(6916009)(66946007)(508600001)(6486002)(83380400001)(26005)(186003)(38100700002)(4326008)(8676002)(9686003)(53546011)(52116002)(6512007)(6506007)(1076003)(38350700002)(316002)(2906002)(86362001)(33656002)(5660300002)(33716001)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B3ZH0Z7qAFaRgfk+zNcAWoV+JNrzF0/MBA1KWd4f7XpYZ1jmTkD9G1ggOFs5?=
 =?us-ascii?Q?xPBpyEzV+mm1Lk6xM/8I69vfd73+sdGo7zx61oIGxY/qqnKFfpyOkHlsvdEv?=
 =?us-ascii?Q?S1T5tQp5zOC4RHTRwJtlLQTNqUNPDE+gmXcvA7PF4PsvV31VLgRYREnT2bZa?=
 =?us-ascii?Q?XFnf89JVqL7MTGk3QzApoeE2cbg08v7bpoUJ9JulLIHlTFU34yUuqZPbGoHZ?=
 =?us-ascii?Q?/FPPnMdYXmVlmSEFvbfFrlcJLqANTZyq6SNYX4dfwyDuAvgRvzw23S3TCEWs?=
 =?us-ascii?Q?IkDADAiveGhfNhRdLurtnKjNLFUiVgid4zLm3eFPfEnB2YtRBcmzM9P+siCJ?=
 =?us-ascii?Q?ybzcpT7onaP3vk6fAbuRC7QoUs4wVpkDwERBvA+IclbR5PgHWXnFZ1fPXKvw?=
 =?us-ascii?Q?zHyCfxviLYKR3W8nwUD/ZsqyMAbAjQeWGVI886LcHmzEGfRtjEJ4yARPCnJA?=
 =?us-ascii?Q?W5AcQnd0QFlQULuERtGrpS4e8aTRWKA3hd96TY7vyVcqoOPgardBXNBKEc9o?=
 =?us-ascii?Q?XkOX5ufdbjq2aVxPXMeYQsiEDBC6bUNwMj1279p+mLIkmB+7+lFDi2zb+xDR?=
 =?us-ascii?Q?Z2mifqYahF30ZPR8RfPFY1YKoWPs8No2QuQU3gatdB/lczkJl7IMzKlck4gP?=
 =?us-ascii?Q?LMNfenmfcQ+UX7j1eWMjJ3DjvWX/cqtOgTtpEKLvlJHzqIzkvcQZRTlw3OgO?=
 =?us-ascii?Q?umhb3roOxQqxQcT0ztMsvLpCmLDJZv+SE4bju2cLRMSjG6jAlMvSqVGGTjvP?=
 =?us-ascii?Q?VA+xy8puLaPeFtIQfO4smKaR2MFid6SqggY7VJYQBplE6M/Iam7RpqIY7tN3?=
 =?us-ascii?Q?2x+AcDvhcDrgEHHVlFLpDeyFNaTtg2P3IaZCyKZxEQvLOqSbup6uI6oZLQQU?=
 =?us-ascii?Q?E/Yc0aZa0rRDFG5ekZnvFkpEiIT2IfkqkP/jwj0cRolsL1M8kFvedVvueUVq?=
 =?us-ascii?Q?Sp3nvyKZxazknXxlsYqqc+6iO3tLQ7828nZhPgeD6fCtUfG2o5n9InmcK4NG?=
 =?us-ascii?Q?dlxglajqrR+x0jQJIM9L7AISDYmpZRZ9Cf5tU5Z+Hu6eSAVprvmRaT7Zk1XW?=
 =?us-ascii?Q?1SZi8It3EU8RpKP2gsrqtRnSfXRDdV/FEdxKJbuSZRD0dCAENOlundJ0Pekf?=
 =?us-ascii?Q?op2uZm1rBMI8BGduGtaS/ljBLikjmOMYapV5xuAZUEEmU1smH8UXcBW7xE71?=
 =?us-ascii?Q?FtkidEt2kSDUlIoQf/KCxKwdJqqAICWsQsY3vmdHnua4eHb7AKNsw8eOuo4L?=
 =?us-ascii?Q?wROjFj3zM5qA8jrjoRs8aqRqwu5bVv0zvjsIQLfeA0k8xg3F+PdiItECP6X2?=
 =?us-ascii?Q?GUUpCPh4bth+zrmTEYq8fk3rlPBvtth4XufqhdDjTQ9rAZhxqyhYF3IE017w?=
 =?us-ascii?Q?FQWWwQ8R5gGzXf+MykC11h+iDTgqi9RuyI5VK+RQoAmXcPx55oRn5h5xsKMP?=
 =?us-ascii?Q?KRoaKrD3i1CHjV4+hkPnqjMKqnyK+KDDi8eM6NDx1hgh1XDQZ4u1fd8oP4Oz?=
 =?us-ascii?Q?6HxiffdYD1KOWv2CCsdRi+vJo9MW+hyqiPGc5JBTb9UTry7nIcUnfGe7TPIj?=
 =?us-ascii?Q?ivPKy5WSMGu9wzjv1kyGtprOaiJnQI1Q73nHo85Nt4Nef4nu4nf6JMSaW2nZ?=
 =?us-ascii?Q?ZsjKL8X/f5s9K+FhCtoCZvshEcF6tJeeqLKkdii+6nnnuWdOw5/rhthiP+A8?=
 =?us-ascii?Q?56pVdHGmXQq38Rpfgn3GWCYkP23OMEoG/5KI1f8+iGLje/xhF83Yh5AbJLMh?=
 =?us-ascii?Q?/R2mK8g/hxYrc8JAzo0GT40RvqqiK0g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404a3c9d-97d3-4a5c-65d8-08da163fb714
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 13:33:33.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7h3/sAsphzaZNChgnnU83zTqFAQotFgoC7UbuxxHv/Mkq+VdIAJesOkE/KArPcRkHafJI9TN7bQBR18+nvotf7TtL5d/x0zA5Mig1DAHXzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3968
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=676 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040077
X-Proofpoint-ORIG-GUID: AccQxUZLVh25-2w8BVO00dctxtTFVUyB
X-Proofpoint-GUID: AccQxUZLVh25-2w8BVO00dctxtTFVUyB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 02:18:04PM +0200, Michael Straube wrote:
> On 4/3/22 14:10, Fabio M. De Francesco wrote:
> > For a list of all the paths to a given function you may use Smatch:
> > 
> > ./smatch/smatch_data/db/smdb.py ips_leave
> > 
> > or
> > 
> > ./smatch/smatch_data/db/smdb.py call_tree ips_leave
> > 
> > But perhaps you already know how to do it.
> 
> Yes, but thank you anyway. :)
> 

My email (gmail account) has been so weird recently.  I don't know why
I'm not getting Fabio's emails...  Presumably they will show up in a few
days.

The other command to use is:

$ ./smatch/smatch_data/db/smdb.py preempt ips_leave
rtw_set_802_11_disassociate() <- disables preempt
-> _rtw_pwr_wakeup()
   -> LeaveAllPowerSaveMode()
      -> ips_leave()

I save that to a file, open it with with vim and run a vim function
`hall` (for highlight all) from my .vimrc file.

" Use :hall to highlight all the words in a file (for debugging sleeping bugs)
function HLall()
  let a=[]
  %s/\w\+/\=add(a, submatch(0))/gn
  let @/ = join(a, "\\|")
endfunction
cnoreabbrev hall call HLall() <CR>:set hls<CR>

That highlights all the functions is the call tree, then I use cscope to
jump to rtw_set_802_11_disassociate and follow the highlighted functions
to ips_leave().

regards,
dan carpenter
