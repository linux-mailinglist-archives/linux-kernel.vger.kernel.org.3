Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000B749D5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiAZXDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:03:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24178 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230344AbiAZXDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:03:07 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKYtNu011847;
        Wed, 26 Jan 2022 23:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=8EPhp0kXU1pgZYdQ1+Va8IcxIvVGws+w0AGnvyrQPlE=;
 b=FzyPb3rbc7q1207RahYSv6SiJY5UFoyzdHdtXoP2kaUHHlMPohfcNJZLInGNCrwexZ7q
 0wVNxupHAcPmU/kOb3fnq96wi9Dirmr9iykaidnrwxAQCmxMIalw1dTbG7NTA7a2QOsv
 /BhEoYEocbrOO+GNssICfC9hI+KuxDz0Z5DSei9g2EFhZQvP0Gnf3gligf+sSN3U1FMy
 8rjwcGTqYd2hMhUKMv501EPeZByizTRFcaf5LJQQAJ0DnU2YSaSK8xcEjpm9IIhj0IIA
 /VZoGtF770vv2+/RefQbrE0B7oDObwep9ZSY/C4B9oaqDNLwz9hZH1TC6szKhbkgl2ME uA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaaffqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:02:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QMoVHZ151216;
        Wed, 26 Jan 2022 23:02:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 3drbcs2njr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:02:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAOumSDg7zLdOYBwTSb0dfdlLtm8Fg4oJvSOV7rQZPsPToExWdnrb34H43V6aX5QMb6mIoICCqFdIChx/E/JbbbWmpiXXMVh/HS31sibl+x98cc0yD8Fuoc2aLEANTvVhHlyGxqO0go+AjrHXOzn+rwSmNqcUNtwhcBAWGJfIH6CTG/Y74gduq0HtakBcoC2W94cqobSuqGQLBz4FSDGEePAnnTE/PeZY49RxF6/mfXKZT3Xt0R8LqpMs0SEL344rMqxbnyvdtM7UB2TV+0VNzTMoE3cDCcrtkFiaWRc34ZqrNsT0Z+cgc13eiEqLzPQdp4d9Rvc9tTyy2vuQmwalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EPhp0kXU1pgZYdQ1+Va8IcxIvVGws+w0AGnvyrQPlE=;
 b=PHe9cmyTvBPy5url2NQUjf/s3e9aXw5WL23SPcNmBWsa759HwF3cedY1nPxtvRdt5Zu/MMh2iZuw0YnE8dCXIpovXWz9f9Fk2QoPucGM+5lDWNfm1VtMdcEfokof10jqs10kQWDRHZ5/2F9QZdWt6iE3ELLDRX9gGabAz2gTUGj1L+Oe+8uFOYZjyaHBFWpz3dSNOVZV89WuVdsRZvgG1JgHAhbJhpndP17sczkppsIEjC+bsFkPxK4AIiy5xdXn2qzDtdQpc37Yc+7widvZMkRzh0dFBuISrA104tzDVYBIxyrUe62fvi+OdHOL2fhu9py8h1qxSRn/u2dwsbfRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EPhp0kXU1pgZYdQ1+Va8IcxIvVGws+w0AGnvyrQPlE=;
 b=QsOHd4eBU26EHNiBrgNZS60fZtxTSS8yGNEZ8/li6cFvKf90WI49z7ftHI8UQsYZ8RwQr+pJ1csXptMK4fzpOxpp0bM0jq033hQo5muxRAFD0xrvZE2gacqYITjCqNTj7MwuP5QybUsAcBQh5FH7UGUM4rAE1TlgU/MiEvrPliY=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MWHPR10MB1615.namprd10.prod.outlook.com (2603:10b6:301:7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 26 Jan
 2022 23:02:34 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 23:02:34 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] printk: reduce deadlocks during panic
Date:   Wed, 26 Jan 2022 15:02:32 -0800
Message-Id: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6117f5ca-6a02-4c2d-b26c-08d9e11ff015
X-MS-TrafficTypeDiagnostic: MWHPR10MB1615:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB16151BE933E44ABE0E47554DDB209@MWHPR10MB1615.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMm6SygKwj7aaYfyWe7ZuoGFzzzpNCGyHrtn+mAVdrhDSAfYfPHPeZz9RHv37Ri3Pet65tATRXbkKIyFQPaL78yq8HZphvUfg/ACkfWy++98BIXXT7a6OlbdoS5annaPaVNaMptL9H0kWKrBcYnhteDwqw1nj5Nya9zsbOt9xRWiIXhWM4f6Sd29kwTvQQ2HSYnKHi9aFfp5erIVxJG5Oia8lri7jm+KiDGO2kAuBeHVjrzXM+mk3Yse2uGinn/BvYb7XWvb5CTv1KrfcC0LMdpW8MCKKGC1jigQ8r7pAXuoT8pPd9OpZJ0q3rcpvYGNC11nozo4uRawXdHsItFhfZ3GcWjwtePJBkHKh9zHTBE/osZdEEnty0zUjn/CMwVaA0wQQ485Qp9BVYCBln2UKup7yAV0z9ljUWy1TiiYgFCSoATr7B3NWRQPHjoL7Ld1WcKX0FosCUDW8bWeBVxulnNdyY2VT2JFui9Hs+Mk8Y/3FDUMTPndt4TAQHdoWCJ/slevmZY1WL50E97lUpM/dIEC8HCN81qJOXhNCDKMatQjR661J+pR9IvBN6hZeMaHI4euXTN1H2LhqoSyxfmiuhOjKq8xfq8TPoH+FFjNMPwZGJyqYL83503gwFnb2tz61RhRCCljUP7QP6Eab+7Aba20lAVsVdQgi15peTFkGoH9rpObkn40xzfgzRznmXBQD2Y9yly3ELvu9MG05mvGMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(2906002)(86362001)(110136005)(54906003)(6506007)(52116002)(5660300002)(38100700002)(38350700002)(508600001)(6486002)(8936002)(103116003)(186003)(4326008)(6512007)(8676002)(66476007)(66556008)(66946007)(316002)(26005)(1076003)(7416002)(2616005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1h7lxRZKRptALKZOHRHalxIJSFeZQpyLGr5zNBlnaU9NVIRJlqEnfk23oWYq?=
 =?us-ascii?Q?KxGRgM0ZQMk3D9jextESaBwF2ZFLwqTYywkAJghk7Bir/UZ/uMMeAxv/Jgk2?=
 =?us-ascii?Q?MFV2nCRFk4tZBLlNul0aj8mSQsDhgmCluoRvAxDFCj3aSVujtmREjLtaMzwZ?=
 =?us-ascii?Q?Bewi3okELWEiWVKR00lZA2UckNIwXCdBUriObRKOwpwlrtnwGbD2HgRkaf3c?=
 =?us-ascii?Q?PJnLWKqxriVz+7gPkmTkG5HqMWz0B2A8kqfckD6vq0AckBD6GEiwOJDpkp9I?=
 =?us-ascii?Q?9ABvrsVwUxxQ06BoWIlMAE8Tev+NKoDuY+PSv0GRPfRG8IVgSaCDEBB1xwB4?=
 =?us-ascii?Q?PQMuuMipEPNNmmiejOQ5uf4hRVoFgiQG9Q9H1SIUelxCswWZIDxGwTYJhyo2?=
 =?us-ascii?Q?5YJngBqLob9/3Icp1hd7CnuNemFgp2SmFcRIFjLaIYNFEHWHGmpa11dN0GSO?=
 =?us-ascii?Q?xdxPQ1VTNwbzzVtckKdjbmnG5XdSyhGv7AHRng+lHTMZ8ZMVOJcCb03lwLqm?=
 =?us-ascii?Q?R+gsYYNQNuIpWQ56to2LcZ5KgApt4NTb+W940rdlxEt5ZI/RF/BXl/gaeAGg?=
 =?us-ascii?Q?rKaJ9Cz+t4N1PodgC9oQ5vm3xOA+X1iSKu7BgGYBQpiAjRI37jowj6NuFptc?=
 =?us-ascii?Q?V/P8OBJcrktRCyeyAVtgqlj58i9CSG+drOhT8bSqxfAGlVnTYqYi99b6QJgP?=
 =?us-ascii?Q?xrOcuw7BchRe15lUDkh/DdvGfGa1wfkF0MG5QxgGIF0PIzOyD0h0BUEG4tlk?=
 =?us-ascii?Q?UTmhH7b3BOI0eZTJbu3ABVXIpLYjf+4D81qBZSqmN7WnFbV01dhcCc7tzC4V?=
 =?us-ascii?Q?F8+qkgE6FX81Iev/H0ZasHT+W3e5R2GJRBI0cMm0FKSe6vV7Ovn9DoDjygkH?=
 =?us-ascii?Q?HWcq3uqlUZuy8tu5W9JV1hEa4SlK1m3YzPAjDqOB5oz80tF9z/g0xhWtHq3g?=
 =?us-ascii?Q?Fo7uTsdLT/j689NTGljOD0S7hF4f3ze/A+nJY7nqTZdTh2AZ/U3RczvFq8hJ?=
 =?us-ascii?Q?HC+eQozNT0t+hpGCCDEv3A6+xHUV1i+Fw9rlIg1Yau+UHgvuiEQMUgQhYDYr?=
 =?us-ascii?Q?lwALPbYUgXf6W+VkMXg+DTKF/dKJt0ALkBwUfx6QLM7NIVUh0uJsld475dqS?=
 =?us-ascii?Q?2hjwPDG7wf0ryWkUhbn+PyqlT3PBaqz9c372BTOjhzgh2sK6C0W2QCVP3e1C?=
 =?us-ascii?Q?N04pOR52A1hz9ygnYRPMtdv9xXfyi6okH0srJIfJp5mQdB231Rgu6B2z+An7?=
 =?us-ascii?Q?QtJELPYIMSzphAPFJqwM3YU9caRDAmVOKg6YhCsY9JeF3IwxN+75gLApPCDK?=
 =?us-ascii?Q?0oNAtnJ4W/Xd+lFEI6RuwbZtWw4T1qwYCR3cwMtbEHrbf0FOiPmDCJePfa5h?=
 =?us-ascii?Q?p1IGnymvB/Xmu9vX7W+NF75WhRSWTsiXRJVZ2cA4xfOR3AreGRR/OjjnyVml?=
 =?us-ascii?Q?v7/ZUZAo5J53f68e7Y5aw6Eiez93JCfz+BIBsY5rzazoXcnTqBttfyvmDs5a?=
 =?us-ascii?Q?9p2efX8VR0ZeP+TmFu3qFc0if861D1/eBU44beMIvp5tisqYZa7Xp/fS/WGN?=
 =?us-ascii?Q?/1zw3rY5hcWwtzKDPwt6jVcZyF5NBNW2hTROUE7szFE5O+hfkCKyLCJnOu7A?=
 =?us-ascii?Q?ExaIsVCsscpjdtNC1izWkz0OJ+vZaU9lyJgF7DGd5cUDiOb+TsgvSaE4Bqu0?=
 =?us-ascii?Q?4p2l0g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6117f5ca-6a02-4c2d-b26c-08d9e11ff015
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 23:02:34.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbKi5zqRTRbx3PC5BOtpJ3PTy7eagwGH7PEQnxJOo1hKgVN5LQvkgWfcTqi/zaTGqVmvQ3sdK5kJkCTlg0EabW2BeJHnqcplYo2mC0XC4f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1615
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260131
X-Proofpoint-GUID: _6aGNX_lN00LnvAcdcON-fbVMf-kvcCZ
X-Proofpoint-ORIG-GUID: _6aGNX_lN00LnvAcdcON-fbVMf-kvcCZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a caller writes heavily to the kernel log (e.g. writing to
/dev/kmsg in a loop) while another panics, there's currently a high
likelihood of a deadlock (see patch 2 for the full description of this
deadlock).

The principle fix is to disable the optimistic spin once panic_cpu is
set, so the panic CPU doesn't spin waiting for a halted CPU to hand over
the console_sem.

However, this exposed us to a livelock situation, where the panic CPU
holds the console_sem, and another CPU could fill up the log buffer
faster than the consoles could drain it, preventing the panic from
progressing and halting the other CPUs. To avoid this, patch 3 adds a
mechanism to suppress printk (from non-panic-CPU) during panic, if we
reach a threshold of dropped messages.

A major goal with all of these patches is to try to decrease the
likelihood that another CPU is holding the console_sem when we halt it
in panic(). This reduces the odds of needing to break locks and
potentially encountering further deadlocks with the console drivers.

To test, I use the following script, kmsg_panic.sh:

    #!/bin/bash
    date
    # 991 chars (based on log buffer size):
    chars="$(printf 'a%.0s' {1..991})"
    while :; do
        echo $chars > /dev/kmsg
    done &
    echo c > /proc/sysrq-trigger &
    date
    exit

I defined a hang as any time the system did not reboot to a login prompt
on the serial console within 60 seconds. Here are the statistics on
hangs using this script, before and after the patch.

before:  776 hangs / 1484 trials - 52.3%
after :    0 hangs /  408 trials -  0.0%

v2:
    Each patch has minor updates from code reviews. I've re-done testing and
    updated the above statistics. Exact changes are in each patch.

Stephen Brennan (4):
  panic: Add panic_in_progress helper
  printk: disable optimistic spin during panic
  printk: Avoid livelock with heavy printk during panic
  printk: Drop console_sem during panic

 include/linux/panic.h  |  6 +++++
 kernel/printk/printk.c | 51 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.30.2

