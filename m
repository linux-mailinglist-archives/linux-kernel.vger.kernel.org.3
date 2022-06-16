Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9E54E5EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377607AbiFPPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350792AbiFPPWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:22:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2610FDE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:22:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GChvX7032716;
        Thu, 16 Jun 2022 15:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sDv/kmLK4PWg8S6ii2GACJrXp599/uxbPFNriXIBizg=;
 b=jaausCMRQ2n1F813fTY3ek5wCXqYaXunA+zwdOnZ0MXxRev0DTz+32b4jzrcSzzwruIe
 faFcyX3YtgX0ySSpgIL9HfP5AJivw6LIeRBAqnENuVQPGTsd7vwtY7RTEKqEyqJj1O6f
 NxhoczTj0n5XUxCDMY7JJzJEJL38Pw5XTkItotjGfoRkRwxBiyTghvHjNvG4GlSYy+yY
 nH1aDY5x41p+IiA1cRaPtF/VEFZWYWRH5XM1QHZzMnyjefbaCYdWzIybJS79YHhg+VvN
 zo7h/nhJ7FJ9DHVNgwGRsU5P4YX522suH3F8+4Lw6KcFHfPU9rChWjPrYHT4RZ5/eskn 6g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2uqh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 15:22:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GFI5fl005144;
        Thu, 16 Jun 2022 15:22:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7q6m5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 15:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRXBWN+QTmdACVY1SwICBvCEWNdCssUW8g9wZugu/I3BnSvCDMPU2IIvXVfz9IUvtRXXbqzofQDKq4DX7rYwWpH+PcKt7WHazrmv2MuFt7M/hrmLVndAfSiu6a0tLPYDkGg5mpwH8aJgcA9YFpgvCHieq6pA0fyjvtfzcWgea3YzI7E3VLQkyZd9oIIOww2FYE2F0Gll3qtbYJlsbR+fZnejkXXaSXLzsn3frtAjB+Jmo/GFAdHvlawb23wXxejXj2xozCCcumtC86Q53CAdUSle3wR2+CB5OmnXVutEXTr+9wpUBPjyd3iBqp7FJhdPfudfJq1BOivJaqelu3bwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDv/kmLK4PWg8S6ii2GACJrXp599/uxbPFNriXIBizg=;
 b=X1eoFLPmf6whKCegVwPqLMw/n/1lqaGvYFXEFX2IM841Erqbg2HK5aM3fdf4LpAWWiMeWipBm4LhUujzK/BwRXuX3YEPPr8PgT+KIkF72kdyXXbGjYzoqnVYOHUpG9rIkh6/Cy1xru2sp9B20jbMU6RCPz9M9ApK5Gn6vYfpcmzch+Ae6vbADTw/3ivO9Vl9kIVQCzKOd99dFy6tMqgHdsfvQCV66HJSrgyLdIQm9aTIsa5wuvCYVtNi/eIv8k/lzzg4DaGVtmMqrdTfUo7QOtGG/RRD/AH2gn3pCmaiYOHSrPTavfSERlF4nLRzczJyhRU3NDncf+Sn7ibD6GDDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDv/kmLK4PWg8S6ii2GACJrXp599/uxbPFNriXIBizg=;
 b=WqgjfGagNiUGKCtCpywk14/YV5qofahu4ftP55w73ZhvHUl3uuRTUVtnKnN5DuBOrFr/0osSNCRYg1iMrWE6ZF1XxvGYSA8CFagTQkwQeWAk4IplaapigiBHpqPyd8BvLeF8mjy2aIanzJxCpz37Oyw5V91Cm0IVpsBVZCWo9As=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 15:22:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 15:22:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTitGaeREyw9E+MZrkNhhszow==
Date:   Thu, 16 Jun 2022 15:22:26 +0000
Message-ID: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e844d63e-7fcb-4f68-fe53-08da4fac050d
x-ms-traffictypediagnostic: DS7PR10MB4832:EE_
x-microsoft-antispam-prvs: <DS7PR10MB4832432610209DD4BAD4C7E093AC9@DS7PR10MB4832.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/dnmk5e8JzDkVlg3EFrvqa3tsYIPzTZfOsl5yWfW6BCJhCjHApcKtP9oHceMDChN5kDnUKZ8lvdh9YnhllI4t52Y4DHeBaj8SygCCVycSk0i2MDnb12D91jhOIvtoef9KAjgDhckdsNMNO9Z1lcmA52MzwA0ofWikJfEAWvfDXuHZTc+BaWjC/cjJBGPphFzygT6zqtdEGPpIWArrxgVJQVhuTvua0ZHvf20AvJq69lFIqjXKMVQv/GjnvjzxSZQuf62Fc7b5lzcQEFi+N9SyD3VMqxW83IGztjozmidRjj7Mg5Wxv5ODi5DuxG59XlcHfj14BJQe3iERlNzGzoq0U/5DmLR16fwvi5Nn0BYrt6Dn33OsrE5SjNiglXvwA9FNs5Lczn3dg0r/Kw4MrceNpucSxRqPjjhAhL0rhuP99ZUi3ssB9DyyodVPJbXZ15gfh13mcjWfiD3cgn46BEDchcJMJ6cic1tDjniW2bb3RJ67YDyTPvhNuWLjA0tEidmhZgzq6nC6NQXA51UYvkjLfFXPLk0cG4zM+Z1wLjQ3fLTU5leucOnYESSFqWojqsksfx6e5OOItg1jFcHE3wRP63eRiP7ouJXOV9+yyq5KLwB8vHTHPBGbyaeLPu0eE/rDLhJGuiYx2BLaT4WdWYg/nHhenkOp5D2Ha2dsFrSCL1408JcHkYzromS0MoBkrpfre7WrfyagueYekCmyR9sGHwHlhDEKHwBctgqGSAMPWRUIVRA29ck6HO9e+MJuxu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(36756003)(316002)(2616005)(186003)(86362001)(33656002)(6916009)(38100700002)(6512007)(26005)(91956017)(2906002)(8676002)(122000001)(64756008)(66476007)(66556008)(76116006)(66946007)(38070700005)(6506007)(4326008)(66446008)(4744005)(508600001)(8936002)(71200400001)(5660300002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c/YMKek85sVnsD4RkCVSSiQ5SOCg+59r2Qn21v/Q6qTKMsLoJQjvfYt3xdOd?=
 =?us-ascii?Q?tJfZ45Z9yInfoZMrbYbwduAnGxynIKd2Qnpx9OKmVTX4EIHpvOYVtKWImBQg?=
 =?us-ascii?Q?ec0WI3tdtnvHekS/Mj+ijm5qvksthsK51jxnYe+q4ZXDds/xG8PDwgcZEUFy?=
 =?us-ascii?Q?64BUCwlRCkvMxZaELllWzWQ25SqN/soqHivjF6ODB6d0vHuy/mUwMmlB/VJz?=
 =?us-ascii?Q?XyVL/I7buFgeehHhRl6wS9GYgcd8LEfAGI3FmJ8oLiwwl2fcTDrL7vRuSuWW?=
 =?us-ascii?Q?FaAyj9SPBYQS7z+5YnpR6PZHkxHxAO6f7/nPNuTmhfKPnDxowcqGR4sfsI4a?=
 =?us-ascii?Q?So8NWTRX2x2bCgsasRoowbtaZTjxzb6YMId+Pamc/MMOG9wGTUe9AYRAzuCE?=
 =?us-ascii?Q?oo3fTq2n9khsfNOWnxrkXWpHao34RLds+UJOYoD0/ecOv9HWslYrjL+Djjax?=
 =?us-ascii?Q?6jvG0mYHTSMdv0tP78+U7vCBuJ0k1TxuB9R7k7ETRSBjkU6AvrUGp1HYthux?=
 =?us-ascii?Q?DRnAjluq8zlAutX/hog2KgkqdEhVoOWA16mMyqPrR1PDYA4KZo9MbfcISmcb?=
 =?us-ascii?Q?JUBv/TJlG45V3YunJ9KAKb6g7teolfgD636nNqZCa2qkWr5L32nC1DbTse6T?=
 =?us-ascii?Q?SgzFULbKM0WhC/Sxf4zXa32+hl5GAbxph0xA2cnRPKjSRT7i1KAbsUb8rVPn?=
 =?us-ascii?Q?GNvDUfl9Uue9dSYL2+0ybqn1yZgqT9jF7FjNqjYN6EMv8Q9Yt7n3AwIzrO3Q?=
 =?us-ascii?Q?9EnXW6Xg4mOwJ5NSnCiFrlD7Q8EOjuYJmxGv37PerOPF6/MEspySTTZ+/eHZ?=
 =?us-ascii?Q?vzHyM5JbW/VjLEZd8GQcmpGEF2wCa8XF2+jndFC8Pot4nqGyqZ8j1aUXluU4?=
 =?us-ascii?Q?64U123JRUCz368LiGXz1dZBsFN08MtfM6g/zfVt/wYGFz/WkrWCgwgsl/cTE?=
 =?us-ascii?Q?IrF4kZiC1PO/H53ifyBN8gVb07fGgG/HgP2MVijwfRKwCfjxeMYWkeLD/YL1?=
 =?us-ascii?Q?wWNdw2S7yG7fwmqESWl0vZrlgt4Dxs1Miuu8JDriKn5/3mN3jsV/V7cnM++e?=
 =?us-ascii?Q?ocXNgma2Iwnx3fp716MTTnmUL+3Ei591hdlsoW3lUgoFSujtynw0q1UHVPer?=
 =?us-ascii?Q?+4z8wmO6rmLz0stxhTRJhbU466cNMGqkNgqCxpdLF5hEkWuAxSWvD87nAn2f?=
 =?us-ascii?Q?gu0TVuc2QX2P62GUwkgJ4URjcPKyZmlzQf6uG4Q7K3QGvhoKOumsIgj9wedo?=
 =?us-ascii?Q?xmBulApN34N/CXYr9OL7m382VlfK70f2x1+3Znjgq2m1WC++zC1Vuv8CW6tb?=
 =?us-ascii?Q?aH096MPc25wV6C7XFG0vkU5lHByBRZorKUL7lrLeUn4XZr1Xd0DmE5hbXLNa?=
 =?us-ascii?Q?id5PuIeymADyrg28J+S8nMW4kOFbeqmLBqtQtvrxGAkLfIm/UQOgLg33EzZ9?=
 =?us-ascii?Q?0rOOzz9ZwxBTBqBHGO/SEA6kUHB3ePavGK20G+ruz+jkyWc6/4fL00tu+8Wt?=
 =?us-ascii?Q?+4MRSYMLKzM/anIaOgV1lLZ2FnP3InmZgIo819h50DYHxnDC0W2wnE7Efu2w?=
 =?us-ascii?Q?jo/2F+TFzDSc7rriZt64G/h+luYosarhJBoe9jxc96faXkRQsCqi0ZCJiN4s?=
 =?us-ascii?Q?W+aH/Th8azoxf5Y7nQeAyI9WFfRdjvaS5SAEBJOW5ry4lfI7ynL3UdH/X00Z?=
 =?us-ascii?Q?IRgcz0lmQuRAs9Bcn0pkAB8EFjlJ0B6Bhl5zmN1deDJ/FOl4yzenQ4G9LeBO?=
 =?us-ascii?Q?F0EUNYgXjlFvXXRICr8idN6k37yuUIs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BBEBFDD772B61439F299CBF623AEB09@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e844d63e-7fcb-4f68-fe53-08da4fac050d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 15:22:26.3806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRZjP93KpUutTMQcnwMLDa8q/IJzyU5xtMc6HpKkRH76/JFO9dX4gE7aAj+oBhVQQRGK6D8gSlOtEIj9QOnXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_10:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=772 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160063
X-Proofpoint-GUID: PiueXX6kuE_ewCR2JirO4OBs2HIeF2Xy
X-Proofpoint-ORIG-GUID: PiueXX6kuE_ewCR2JirO4OBs2HIeF2Xy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve-

Since v5.19-rc1, trace_printk() no longer displays a function
name, but rather a kernel address. I don't have time at the
moment to track this down to a specific commit, just parking
it here in case someone can get to it sooner than me.

          <idle>-0     [003]   269.397568: bprint:               0xffffffff=
c0cccab7: nf=3D0xffff888172dbfba0 still on the LRU or a dispose list
          <idle>-0     [003]   269.397576: bprint:               0xffffffff=
c0cccafa: nf=3D0xffff888172dbfba0
          <idle>-0     [003]   269.397583: bprint:               0xffffffff=
c0cccab7: nf=3D0xffff8881726cd4d8 still on the LRU or a dispose list
          <idle>-0     [003]   269.397584: bprint:               0xffffffff=
c0cccafa: nf=3D0xffff8881726cd4d8



--
Chuck Lever



