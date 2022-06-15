Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0779E54C4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345502AbiFOJip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbiFOJi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:38:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA5A2F3BE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:38:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F6uNDE015214;
        Wed, 15 Jun 2022 09:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=k3MLQI8RDhAargBC3X6A4EukQ/m3YiBKwxiGkYE5Cdc=;
 b=sWCIOGkp2Um/pPEoDMCEu/XK6gxDDGiYzOYUbSb9MS6M5HDWEcFjRongB5tLy0b2H6Yu
 RUmX/ujTabSDFY+/oYHboS/zTNFO1rJL0t80vTcpVVUSHrY10zfQ5UGaPViJ/LnudFse
 7rycSTrQd8zPL0Ria999EjIHtbxDmh/LarxzLg6okbr6cw5jAzxYIMn/QE4INXXVzOBy
 +mb1ndROj6dkjVvKi2zd46EZFff5qR9g0YjHLMmHDJqIDdG3Xmu7TlcVAVV3h9AIZEjE
 6KbrO8PkgETgNLf8LSr3YMol3vBoEv6e0pR+iTJ0GF68bM9XcGRwbUBKTK4XHXZokgTX sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0g5qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 09:38:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F9aCpm016441;
        Wed, 15 Jun 2022 09:38:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr2a25rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 09:38:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb5lhN3V8mKEM5evP9twpJvhZLQ9GGUby65toFWPEi7l4yxeHR7LK0NwlO30qB/Y7J7JAJRvlKKh3PzmqaR1FnLergkNDhRhrJjtHWxq8JrWLPpImpd3daFJ+mR1Y6nig38+dOjmQMBtbsnyCl2NrW7AZB55OEe01vfDGUTcO3IbAC5RcWpQV5Y8wIxE3cQSJp9c/De0Vq1My4C4taS7EnEEsfsF3rYmpZK+qrfyAbqGbk3ZePDLx6c49MLswVJ58r/LVcqzEZXS7VN+TH+iGHp1J7aL+14ZJk1SQcX3k1o32P6qoNokuy8emK834Bg/V3V7RX/iLZWSdMFAhKkJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3MLQI8RDhAargBC3X6A4EukQ/m3YiBKwxiGkYE5Cdc=;
 b=E/ID+5fxjnu9H+y0Gy2ikCtYeGny34EXhsd/P11FWFFDqGvYQSFCDfeilnpbiTHNHtD8HPT2ks8Ge5b3JEYkyfw7kF7bY5bRRNN1Zsq+OyE1aE3CeA5rroxRrXc+I5y1NnFDmdrZXGjet6oBSQPbpTvcVHtc059yAjWZOIPggvVXfwzy+NAjq8xm9B7cSXKXH/uCL2MPkXdtq4XYhd8TQAvBIUo43iqn/FjnfDKLRfwmlxMh80MKgCy5emNzQZToRRCGnM89EZHUTwVGMS7uWw/zpWw1Wc6Hym2Dp4LXweM1HPx7DTCtC1QP4PeWxE4YDSpsA0jxxBp/Gis3vNZm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3MLQI8RDhAargBC3X6A4EukQ/m3YiBKwxiGkYE5Cdc=;
 b=Qho4IKmtT0bQWbLa1wOCNKp7wvHwrgwQX5snzHxwUE8T3+n57/klXTUhlpcmsEFYNVjuWePpHAVvRbszC0UzzVcj/ISbnlT2LVcxGl8sRkhDnyoY68mVBLLfceP8/lQj/pgfoB9+gcmKFsYjRXxudXr56JdsDxaa0OulqYYJ+z0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM4PR10MB6184.namprd10.prod.outlook.com
 (2603:10b6:8:8c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 09:38:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 09:38:11 +0000
Date:   Wed, 15 Jun 2022 12:37:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Shyam Prasad N <sprasad@microsoft.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbuild] [samba-ksmbd:for-next 2/5] fs/cifs/smb2ops.c:571
 parse_server_interfaces() warn: sleeping in atomic context
Message-ID: <202206151736.Oy7RWMHu-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: SOVJGQRYD4YQEDSP5O2LMKU2YEYQXM6I
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00b07f69-afae-4e82-fbfd-08da4eb2c318
X-MS-TrafficTypeDiagnostic: DM4PR10MB6184:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB61841370C3CA3908C919BF968EAD9@DM4PR10MB6184.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wj0TXN/elSnnGkvUJQyKSvstFrY8J8Hyi3km5IuoAbKj0yDk5uVF67iHDOvu2eu+7rMX1KKsILnWdnfkBuP6RQQG5vvBjKjSMZONuYC6FCAN+/TX6dgy04iPi7PedQBDP8DLjQgicEaHU0oAYYZs45DSnN/t5xiG4yZU/TtCPbm2ky4aWu/B9AHwg4sDG1EMS8yxGfKcCtJGhSux/WEMad+sMllhCwT2dMleTuxuI9MQigdzfqI5dNzsU4Be8jLRhGG9CEMd9X+WW9WKiQbDsyuirT/QMzfUgRuy7eRY1/c0Fg8zdbdAARWnuidr2+H5qbMLAgwEfMqHdLPFvjMq+mLyicqGfRlFxuagoURQL4Vai3hL77EQp5BYulmEQyalgS78DnfD5OKklIE8QzXE20Ff2Ew6w/6LbSDBP7a1G7/PxA6n0dwS6RFbJIyHAbzVRHuxFok5D6/yVioFbLk4/8epxho3D7Eea6w+faM6vuA5SUsZ1BpJnV7khSFevVs4nItEaXjP23wuy4XSXvHLDJveKyC8lJ+zFAPdgdQVFNaJm4x5J2WngJ20CUeu0gtXe5Zi4QlB8D0FN9YL1p7ONeTxK7XWb2KXCOgBVhGDNszXonb7fPdEqjoko8wW+EbHgKer2BvWDT8PP+nRM+H0eJmIaqr7BJRtfeMcniXZjtJZ/uIGyeBio+vDRoGHQbyoCkL56fYE6JUVN3OljqlrVCHL/y2jmDi6nJRCXyifoiUjIOXDZ4iA3LEKZUeqgIx9MasgMMe4nEniA1TPdoys7g65aXhoWBcBrScMD1flQJnRUf7qYaeBEt/nEK7PtTnY9u1E7w7vzowXjxPYDkaLO5ijqU60u6p/n+Se4bolATNRpkzUslPtYt9w845UbDdG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(508600001)(44832011)(6512007)(30864003)(316002)(9686003)(26005)(86362001)(4326008)(6666004)(52116002)(66556008)(66476007)(8676002)(66946007)(6506007)(1076003)(966005)(6916009)(38100700002)(6486002)(5660300002)(8936002)(38350700002)(36756003)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5G56HCbbMVYohhdAa3IXUr1ob31i4dVHsQW0YwhRrn8ptOm9to3euIQc80OB?=
 =?us-ascii?Q?H2gHd6YrVtQwNDfP/glgQClvwR48t+lnMdApM5aXbg57UTz2EtK5li6jHfne?=
 =?us-ascii?Q?6Y3BNFMVe8xrNr9fpVX5ohAj+uEehzVlCf7/X5t5A6194bOMfzRc0I0mIexg?=
 =?us-ascii?Q?HdFkOV369VCyqA0SgRuiJJY2KOmorxPl1JaF/tF3H/EclqoUrTvUKMy0IUKe?=
 =?us-ascii?Q?TjsyGffxSd8NYOC/4EyEycUCsb3FVNkmzdnY6xpJoFwn+3TZZJXK1rzQu1tM?=
 =?us-ascii?Q?r3Pls6ZwfMxtTDTRlfab5+dr+OoSK3uwaEApaK64YoufU7hv8UNYeYK04/ib?=
 =?us-ascii?Q?YI4nUXn0I3KH+5y+RDozsmblXxtGtSIlMS8UU5J1+hSmX/cG8ACMqoux5we2?=
 =?us-ascii?Q?ZWmtDXUWh/aPesQGzFbttP+nxL+tknwFZ3/nLhXpmHxvsdYg4uLXZxI69Mh1?=
 =?us-ascii?Q?R5xIiHNbTolew+xs/QTBxgxkldWs2EuvlCajhlBq4nuTNT3K1uXLh5A7FWCY?=
 =?us-ascii?Q?jvnsDWtt0I1DC84PpoumCFm2nUpyEtvFXJCXIHkUumSCQEA6DPrBh0KwRlP2?=
 =?us-ascii?Q?ZgZFkY7kt7jImaotoKn+I5zay4XxEGSYfck4jpioPJZe86RT3Duo79ruPZgg?=
 =?us-ascii?Q?xlFYFiSPlGfLphvZtv2haXkT8u90+dbFE+CyZqZPFSQl6gxwIRO407kMjsSd?=
 =?us-ascii?Q?7J/wnAW0aVfNFw34VHnFYtJTyIO3x8SeOJElj6UGt6Ty/JlINnxhJD1WyKOL?=
 =?us-ascii?Q?SmFSKVsHZjNglLwxTisyhbfe8yPGznjhrZiMFKkz91yzmctqL1CfyVyzYeYk?=
 =?us-ascii?Q?UQjlftJnOrVTZfsFgdJyOTpCziArMf9AWtFjFCRi1FvDc+HL9y8JPxiXReHM?=
 =?us-ascii?Q?apoIrJi2eHd/bexU4Lpr5ly2UzvYVfIz46Byg+yXQSVKfVVzq8iFc9a2/tqV?=
 =?us-ascii?Q?ciOHivj9PMGcudeL4zc7a5ujlRe1vEt5ZWoKlspyNDdV7JwvHSYNR5L6E3jI?=
 =?us-ascii?Q?a/j4ywozKU7NGc1SxzLca1C5XB642FtkXhuUZoWurtKcJOKjwYkEkgTA8oao?=
 =?us-ascii?Q?LOHPa/hIvGW/4+eBpjiguz4nxBgMP0eW9LMque8tp1c9L/Ajr3v/0ZUttLHE?=
 =?us-ascii?Q?1m/poi01Icv4q2Mdi/eBZbn24JvuXgXFMjDdI4C35sLwJzyC8mXkWOIduAYq?=
 =?us-ascii?Q?Tthm91I6BJ+/n8Ic8NQeH+KJnLzlVrobUAcc8D1z7zPIEl3ph/jejYVXEDGD?=
 =?us-ascii?Q?Pg+KUipoRlIo/SZTDyOIjvWXv7u5ED3Yhcw08/ABnRpUAgr842Vdtuwl9ZTk?=
 =?us-ascii?Q?Nr3aL1AKeGkmASQBvslM1mvvchKI5UGero3T72sfeL2SrU2xn5M0yd1nxJJ6?=
 =?us-ascii?Q?wlNaZQRB7AXfnK8xaDhvAlBc7X2kssJSbfG7vJV4OBswSTAnprS+6SJPQ+UO?=
 =?us-ascii?Q?Ja1WIfESH1OlVloImfhXpC/0uVxpFkFoPSFhmQOBLXe3cjav+8sdr8I0tZ0h?=
 =?us-ascii?Q?pA+evAHPiAfwUyGfK1F2sMCb3sfxoV6vN6uU2KvIPZEKEWHSh67QlS/FzIb8?=
 =?us-ascii?Q?fwtVWwrXLWJJ+egnQGeYqYcipefFcwaKsLjVbeObSdOZISX4nYwtndZqs1Ss?=
 =?us-ascii?Q?T/cJ0W4g4wFlyCfRQ7ONmTUwL3WkcyJYRtU/39WBSXYtrMlwrQB0rJzoxqXr?=
 =?us-ascii?Q?YnJYDUnEGBNaevCKModVPy+HAj+mBKwJfFyI7HFVZXhgv6AX0+egNAWqH5V0?=
 =?us-ascii?Q?gaPyTbEiW9pj6P7oe/kNSGP+WTcoSxc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b07f69-afae-4e82-fbfd-08da4eb2c318
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:38:11.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VsqPBUaR0sqTTI2bKgTMCQ7cdmfzvjosIYDUazWHWQ2SnR3zqYlD3ooH5RsG6u2vzuuG990aGuxCh+1WLGE22IJN/myxO6L13D3XXutAfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_03:2022-06-13,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150036
X-Proofpoint-GUID: tb8sOqIE_yq333H_3sO6rmhuqtXd78Hu
X-Proofpoint-ORIG-GUID: tb8sOqIE_yq333H_3sO6rmhuqtXd78Hu
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.samba.org/ksmbd.git for-next
head:   43c233283f928be86531f030c8a3faa497a30e15
commit: 29c5f6efd1d496330e43ed2779ed371663f446b5 [2/5] cifs: change iface_list from array to sorted linked list
config: i386-randconfig-m021-20220613 (https://download.01.org/0day-ci/archive/20220615/202206151736.Oy7RWMHu-lkp@intel.com/config )
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/cifs/smb2ops.c:571 parse_server_interfaces() warn: sleeping in atomic context

vim +571 fs/cifs/smb2ops.c

fe856be475f7cf Aurelien Aptel 2018-06-14  512  static int
fe856be475f7cf Aurelien Aptel 2018-06-14  513  parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
fe856be475f7cf Aurelien Aptel 2018-06-14  514  			size_t buf_len,
29c5f6efd1d496 Shyam Prasad N 2022-01-01  515  			struct cifs_ses *ses)
fe856be475f7cf Aurelien Aptel 2018-06-14  516  {
fe856be475f7cf Aurelien Aptel 2018-06-14  517  	struct network_interface_info_ioctl_rsp *p;
fe856be475f7cf Aurelien Aptel 2018-06-14  518  	struct sockaddr_in *addr4;
fe856be475f7cf Aurelien Aptel 2018-06-14  519  	struct sockaddr_in6 *addr6;
fe856be475f7cf Aurelien Aptel 2018-06-14  520  	struct iface_info_ipv4 *p4;
fe856be475f7cf Aurelien Aptel 2018-06-14  521  	struct iface_info_ipv6 *p6;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  522  	struct cifs_server_iface *info = NULL, *iface = NULL, *niface = NULL;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  523  	struct cifs_server_iface tmp_iface;
fe856be475f7cf Aurelien Aptel 2018-06-14  524  	ssize_t bytes_left;
fe856be475f7cf Aurelien Aptel 2018-06-14  525  	size_t next = 0;
fe856be475f7cf Aurelien Aptel 2018-06-14  526  	int nb_iface = 0;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  527  	int rc = 0, ret = 0;
fe856be475f7cf Aurelien Aptel 2018-06-14  528  
fe856be475f7cf Aurelien Aptel 2018-06-14  529  	bytes_left = buf_len;
fe856be475f7cf Aurelien Aptel 2018-06-14  530  	p = buf;
fe856be475f7cf Aurelien Aptel 2018-06-14  531  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  532  	spin_lock(&ses->iface_lock);
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Holding a spinlock

29c5f6efd1d496 Shyam Prasad N 2022-01-01  533  	/*
29c5f6efd1d496 Shyam Prasad N 2022-01-01  534  	 * Go through iface_list and do kref_put to remove
29c5f6efd1d496 Shyam Prasad N 2022-01-01  535  	 * any unused ifaces. ifaces in use will be removed
29c5f6efd1d496 Shyam Prasad N 2022-01-01  536  	 * when the last user calls a kref_put on it
29c5f6efd1d496 Shyam Prasad N 2022-01-01  537  	 */
29c5f6efd1d496 Shyam Prasad N 2022-01-01  538  	list_for_each_entry_safe(iface, niface, &ses->iface_list,
29c5f6efd1d496 Shyam Prasad N 2022-01-01  539  				 iface_head) {
29c5f6efd1d496 Shyam Prasad N 2022-01-01  540  		iface->is_active = 0;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  541  		kref_put(&iface->refcount, release_iface);
fe856be475f7cf Aurelien Aptel 2018-06-14  542  	}
fe856be475f7cf Aurelien Aptel 2018-06-14  543  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  544  	while (bytes_left >= sizeof(*p)) {
29c5f6efd1d496 Shyam Prasad N 2022-01-01  545  		memset(&tmp_iface, 0, sizeof(tmp_iface));
29c5f6efd1d496 Shyam Prasad N 2022-01-01  546  		tmp_iface.speed = le64_to_cpu(p->LinkSpeed);
29c5f6efd1d496 Shyam Prasad N 2022-01-01  547  		tmp_iface.rdma_capable = le32_to_cpu(p->Capability & RDMA_CAPABLE) ? 1 : 0;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  548  		tmp_iface.rss_capable = le32_to_cpu(p->Capability & RSS_CAPABLE) ? 1 : 0;
fe856be475f7cf Aurelien Aptel 2018-06-14  549  
fe856be475f7cf Aurelien Aptel 2018-06-14  550  		/*
29c5f6efd1d496 Shyam Prasad N 2022-01-01  551  		 * The iface_list is assumed to be sorted by speed.
29c5f6efd1d496 Shyam Prasad N 2022-01-01  552  		 * Check if the new interface exists in that list.
29c5f6efd1d496 Shyam Prasad N 2022-01-01  553  		 * NEVER change iface. it could be in use.
29c5f6efd1d496 Shyam Prasad N 2022-01-01  554  		 * Add a new one instead
fe856be475f7cf Aurelien Aptel 2018-06-14  555  		 */
29c5f6efd1d496 Shyam Prasad N 2022-01-01  556  		list_for_each_entry_safe(iface, niface, &ses->iface_list,
29c5f6efd1d496 Shyam Prasad N 2022-01-01  557  					 iface_head) {
29c5f6efd1d496 Shyam Prasad N 2022-01-01  558  			ret = iface_cmp(iface, &tmp_iface);
29c5f6efd1d496 Shyam Prasad N 2022-01-01  559  			if (!ret) {
29c5f6efd1d496 Shyam Prasad N 2022-01-01  560  				/* just get a ref so that it doesn't get picked/freed */
29c5f6efd1d496 Shyam Prasad N 2022-01-01  561  				iface->is_active = 1;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  562  				kref_get(&iface->refcount);
29c5f6efd1d496 Shyam Prasad N 2022-01-01  563  				goto next_iface;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  564  			} else if (ret > 0) {
29c5f6efd1d496 Shyam Prasad N 2022-01-01  565  				/* all remaining ifaces are slower */
29c5f6efd1d496 Shyam Prasad N 2022-01-01  566  				break;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  567  			}
29c5f6efd1d496 Shyam Prasad N 2022-01-01  568  		}
fe856be475f7cf Aurelien Aptel 2018-06-14  569  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  570  		/* no match. insert the entry in the list */
29c5f6efd1d496 Shyam Prasad N 2022-01-01 @571  		info = kmalloc(sizeof(struct cifs_server_iface),
29c5f6efd1d496 Shyam Prasad N 2022-01-01  572  			       GFP_KERNEL);

Cannot do a sleeping allocation.  Must be GFP_ATOMIC.

29c5f6efd1d496 Shyam Prasad N 2022-01-01  573  		if (!info) {
fe856be475f7cf Aurelien Aptel 2018-06-14  574  			rc = -ENOMEM;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  575  			spin_unlock(&ses->iface_lock);
fe856be475f7cf Aurelien Aptel 2018-06-14  576  			goto out;
fe856be475f7cf Aurelien Aptel 2018-06-14  577  		}
29c5f6efd1d496 Shyam Prasad N 2022-01-01  578  		memcpy(info, &tmp_iface, sizeof(tmp_iface));
fe856be475f7cf Aurelien Aptel 2018-06-14  579  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  580  		/* add this new entry to the list */
29c5f6efd1d496 Shyam Prasad N 2022-01-01  581  		kref_init(&info->refcount);
29c5f6efd1d496 Shyam Prasad N 2022-01-01  582  		info->is_active = 1;
fe856be475f7cf Aurelien Aptel 2018-06-14  583  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  584  		cifs_dbg(FYI, "%s: adding iface %zu\n", __func__, ses->iface_count);
fe856be475f7cf Aurelien Aptel 2018-06-14  585  		cifs_dbg(FYI, "%s: speed %zu bps\n", __func__, info->speed);
fe856be475f7cf Aurelien Aptel 2018-06-14  586  		cifs_dbg(FYI, "%s: capabilities 0x%08x\n", __func__,
fe856be475f7cf Aurelien Aptel 2018-06-14  587  			 le32_to_cpu(p->Capability));
fe856be475f7cf Aurelien Aptel 2018-06-14  588  
fe856be475f7cf Aurelien Aptel 2018-06-14  589  		switch (p->Family) {
fe856be475f7cf Aurelien Aptel 2018-06-14  590  		/*
fe856be475f7cf Aurelien Aptel 2018-06-14  591  		 * The kernel and wire socket structures have the same
fe856be475f7cf Aurelien Aptel 2018-06-14  592  		 * layout and use network byte order but make the
fe856be475f7cf Aurelien Aptel 2018-06-14  593  		 * conversion explicit in case either one changes.
fe856be475f7cf Aurelien Aptel 2018-06-14  594  		 */
fe856be475f7cf Aurelien Aptel 2018-06-14  595  		case INTERNETWORK:
fe856be475f7cf Aurelien Aptel 2018-06-14  596  			addr4 = (struct sockaddr_in *)&info->sockaddr;
fe856be475f7cf Aurelien Aptel 2018-06-14  597  			p4 = (struct iface_info_ipv4 *)p->Buffer;
fe856be475f7cf Aurelien Aptel 2018-06-14  598  			addr4->sin_family = AF_INET;
fe856be475f7cf Aurelien Aptel 2018-06-14  599  			memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
fe856be475f7cf Aurelien Aptel 2018-06-14  600  
fe856be475f7cf Aurelien Aptel 2018-06-14  601  			/* [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these */
fe856be475f7cf Aurelien Aptel 2018-06-14  602  			addr4->sin_port = cpu_to_be16(CIFS_PORT);
fe856be475f7cf Aurelien Aptel 2018-06-14  603  
fe856be475f7cf Aurelien Aptel 2018-06-14  604  			cifs_dbg(FYI, "%s: ipv4 %pI4\n", __func__,
fe856be475f7cf Aurelien Aptel 2018-06-14  605  				 &addr4->sin_addr);
fe856be475f7cf Aurelien Aptel 2018-06-14  606  			break;
fe856be475f7cf Aurelien Aptel 2018-06-14  607  		case INTERNETWORKV6:
fe856be475f7cf Aurelien Aptel 2018-06-14  608  			addr6 =	(struct sockaddr_in6 *)&info->sockaddr;
fe856be475f7cf Aurelien Aptel 2018-06-14  609  			p6 = (struct iface_info_ipv6 *)p->Buffer;
fe856be475f7cf Aurelien Aptel 2018-06-14  610  			addr6->sin6_family = AF_INET6;
fe856be475f7cf Aurelien Aptel 2018-06-14  611  			memcpy(&addr6->sin6_addr, &p6->IPv6Address, 16);
fe856be475f7cf Aurelien Aptel 2018-06-14  612  
fe856be475f7cf Aurelien Aptel 2018-06-14  613  			/* [MS-SMB2] 2.2.32.5.1.2 Clients MUST ignore these */
fe856be475f7cf Aurelien Aptel 2018-06-14  614  			addr6->sin6_flowinfo = 0;
fe856be475f7cf Aurelien Aptel 2018-06-14  615  			addr6->sin6_scope_id = 0;
fe856be475f7cf Aurelien Aptel 2018-06-14  616  			addr6->sin6_port = cpu_to_be16(CIFS_PORT);
fe856be475f7cf Aurelien Aptel 2018-06-14  617  
fe856be475f7cf Aurelien Aptel 2018-06-14  618  			cifs_dbg(FYI, "%s: ipv6 %pI6\n", __func__,
fe856be475f7cf Aurelien Aptel 2018-06-14  619  				 &addr6->sin6_addr);
fe856be475f7cf Aurelien Aptel 2018-06-14  620  			break;
fe856be475f7cf Aurelien Aptel 2018-06-14  621  		default:
fe856be475f7cf Aurelien Aptel 2018-06-14  622  			cifs_dbg(VFS,
fe856be475f7cf Aurelien Aptel 2018-06-14  623  				 "%s: skipping unsupported socket family\n",
fe856be475f7cf Aurelien Aptel 2018-06-14  624  				 __func__);
fe856be475f7cf Aurelien Aptel 2018-06-14  625  			goto next_iface;
fe856be475f7cf Aurelien Aptel 2018-06-14  626  		}
fe856be475f7cf Aurelien Aptel 2018-06-14  627  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  628  		if (!list_entry_is_head(iface, &ses->iface_list, iface_head))
29c5f6efd1d496 Shyam Prasad N 2022-01-01  629  			list_add_tail(&info->iface_head, &iface->iface_head);
29c5f6efd1d496 Shyam Prasad N 2022-01-01  630  		else
29c5f6efd1d496 Shyam Prasad N 2022-01-01  631  			list_add_tail(&info->iface_head, &ses->iface_list);
29c5f6efd1d496 Shyam Prasad N 2022-01-01  632  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  633  		ses->iface_count++;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  634  		ses->iface_last_update = jiffies;
fe856be475f7cf Aurelien Aptel 2018-06-14  635  next_iface:
29c5f6efd1d496 Shyam Prasad N 2022-01-01  636  		nb_iface++;
fe856be475f7cf Aurelien Aptel 2018-06-14  637  		next = le32_to_cpu(p->Next);
29c5f6efd1d496 Shyam Prasad N 2022-01-01  638  		if (!next) {
29c5f6efd1d496 Shyam Prasad N 2022-01-01  639  			bytes_left -= sizeof(*p);
fe856be475f7cf Aurelien Aptel 2018-06-14  640  			break;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  641  		}
fe856be475f7cf Aurelien Aptel 2018-06-14  642  		p = (struct network_interface_info_ioctl_rsp *)((u8 *)p+next);
fe856be475f7cf Aurelien Aptel 2018-06-14  643  		bytes_left -= next;
fe856be475f7cf Aurelien Aptel 2018-06-14  644  	}
29c5f6efd1d496 Shyam Prasad N 2022-01-01  645  	spin_unlock(&ses->iface_lock);
fe856be475f7cf Aurelien Aptel 2018-06-14  646  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  647  	if (!nb_iface) {
29c5f6efd1d496 Shyam Prasad N 2022-01-01  648  		cifs_dbg(VFS, "%s: malformed interface info\n", __func__);
fe856be475f7cf Aurelien Aptel 2018-06-14  649  		rc = -EINVAL;
fe856be475f7cf Aurelien Aptel 2018-06-14  650  		goto out;
fe856be475f7cf Aurelien Aptel 2018-06-14  651  	}
fe856be475f7cf Aurelien Aptel 2018-06-14  652  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  653  	/* Azure rounds the buffer size up 8, to a 16 byte boundary */
29c5f6efd1d496 Shyam Prasad N 2022-01-01  654  	if ((bytes_left > 8) || p->Next)
29c5f6efd1d496 Shyam Prasad N 2022-01-01  655  		cifs_dbg(VFS, "%s: incomplete interface info\n", __func__);
fe856be475f7cf Aurelien Aptel 2018-06-14  656  
35adffed079fdc Aurelien Aptel 2019-09-20  657  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  658  	if (!ses->iface_count) {
29c5f6efd1d496 Shyam Prasad N 2022-01-01  659  		rc = -EINVAL;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  660  		goto out;
29c5f6efd1d496 Shyam Prasad N 2022-01-01  661  	}
29c5f6efd1d496 Shyam Prasad N 2022-01-01  662  
29c5f6efd1d496 Shyam Prasad N 2022-01-01  663  out:
29c5f6efd1d496 Shyam Prasad N 2022-01-01  664  	return rc;
35adffed079fdc Aurelien Aptel 2019-09-20  665  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

