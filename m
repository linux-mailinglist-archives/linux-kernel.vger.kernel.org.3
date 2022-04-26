Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BC0510197
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351960AbiDZPNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352163AbiDZPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F115B465
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT57X025802;
        Tue, 26 Apr 2022 15:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vPu8InHEo9CrYf6Z7TSxTZfXKyd+wmOWcLipwJuqZlM=;
 b=RLxKHUQlnfsOYnrP3ASipCTdYlp7mlxGxLzjfc+jAOOiKvUdKfboPHNzIN7nrFtndWwE
 aYLd7RELjLzWBeJNVnBQScV9r+6FpHAxZ/m4QaJjpNSX+BxP4lS0NSICU645c2UeoRQp
 neiJlcS9/xkCj1KTJl8MiWyPwsbX8ojTT0CXC+374wvmJkr08nBHl3cVgPAbywEP3R+y
 UjDksYjjl1YoQnQLJoc6geSHsRwnPRb56pbPkTXwsKaAp+iJf2Y4b16yBCzsu5zxSFpz
 et/guOaLn9lpxxwRCtZYZKPbbxh8GxiP4f6P63W+v/E3am+Fh88oim14zu5wl97vNobR BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mpdgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6USZ037884;
        Tue, 26 Apr 2022 15:07:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkuq9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dz0JoA6E3BU+O/t80EBs3znl5bkEOX6ZSQIEgDXiAvoZgcEC1eaXhALY2EHmX0WxKrWIhIkWQFKxpmE7fM13hlNCzjlGwvIzXbYpKnxdsIwAps0kZQQevjNtSyxCT1TSG04hF/iCrx620UuyXVvMYfEB0TkuRP55oejPyqk0PABze4uPN8JbuaBcNfH+VHqWt4yPa9ekcXMQPzvHXDyds97LhApyXv/IFK4rVmzK54mrsDRaQCYXxvMGHFi9z3Ngs2iBKhuh+RFn5oHMKEhW4xr3rDzIsblnUcBq0EJf2ZnXy7egVmWL1RUhQ2LuFnlo9fwNvbqb/wJWPZu3sRM81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPu8InHEo9CrYf6Z7TSxTZfXKyd+wmOWcLipwJuqZlM=;
 b=Z5+CiDaQG2tdunse2gk4S+7aiPa1yeLdb4nfKMeGm0F+HZ0nI1Qwu1lm+2rC0d4D9S/mYkOtBtKSw3R3LMBNGpqHGgaQVYjOU4drtuQMuLjmiRlYbm3G2v4j56wPlqy21kj88n5vpnDh+fB2Z2+kZI7ekwuuURXjKMAo7MSaf46+vDJHsI7SvC4juZUj9CEweXHfJtcVrmXJm6etBKVkwEUWrH7Y2lm38VwGMhFa8ysBtrza8MlgahVbVrqrb6Hzu9exioMMezJWW836crBeSAjJaMSZV82dsuRmadOIsLmDQJDasHQOK69YT9dgdq/7KyN8YHCnc55JvAXfTMqiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPu8InHEo9CrYf6Z7TSxTZfXKyd+wmOWcLipwJuqZlM=;
 b=DGibhQq2mrq7c7aImzenLcT6VAmSS+LdOtulz1rgJ9rprXckWjpm67WLeQdi0wHdU1eIUeNGw6HQeaSncMO90PBydv3/sydJ0teV/A3kNFCdlkKFTyDzgiHrJ5KsOmiOObLqwDvRhy5/soYOwWmzVtr1M3ruDpzPDBWbqEQm5a0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:07:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 56/70] mm/memcontrol: stop using mm->highest_vm_end
Thread-Topic: [PATCH v8 56/70] mm/memcontrol: stop using mm->highest_vm_end
Thread-Index: AQHYWX9Alc9b5GzkOEa4zECloujcbg==
Date:   Tue, 26 Apr 2022 15:06:48 +0000
Message-ID: <20220426150616.3937571-57-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4309fbfe-a0d4-4f57-6f1d-08da27967d55
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2377D9BDD762FE0F42AB5618FDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KOyzGbvJ8HI/DZ38JEdy4wV+8pj89Wj8MMwSk2TH6g5t09orJyRSRPqv1kCPvZCZPyMWgxdYbitn9Zlx4+cfmQ/Fo9AMRS3N3RLnAdHjGvL1YCDVG48LFz0ZzXlRm3oBVBmlcYGnOnaTJqSXBYyVAdCVSe+qyXk5Ujrwzg1IxIcP6hD9qNb9NuVYeFq3B1IYV1EdODU4WQ3d/YPAtYkKMiIxGTGJr3koY74hgLtXdTZYCB/UT0UMstZ7N5idWeNktWAqAJZBmrlxHyqZUp6PcQY48xZxrSPWeTT///meV6MN7EWieKiISyyjy02vMXb6my6uFWenQGhHN1yR18EG4j99nZk7VDhBDaHbH82eQwcHQ8Tbe5lJWVDcjb9Hffgo15SPvF9qa1j9OsUPwTcZlfunV7Ei+WDhL8iY7HprTdBqe2wX4vn/VwEnLKLKL+ng53BdQ90/b400QXDqHbkr7uelTxZck4tu1CVWli7nSje3Va3iiLVr5j2/FLpSA27ewO/PLv1t7o5i86azlHQ5fjXiadb91rz8LWgk+BvhoinyBlLzjW6K3A2z4A4bV8VIN6OLULWzMaxoGJvMg/QCxKuj3Q9CX9KpWRGC1nWpCIYkw0fEi+HXiAzkEvLJ1Q+DujiHzX86WGBlpBNepr31wGiZPCRedovg2b4DKnKVJzrUhYB6ttCm/UpzLWdjF/4A+7rYosPWSj0+llfGF9BfgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fCdrVz599VZ70nV/Xc8QCcsMCmM9DcZ4Dc35zGSJq5AS+yTvevgVoS9z9g?=
 =?iso-8859-1?Q?KhmGBSkz11aEBZMQPgHM2H5PNMcydkbm5cC1iODeWDb1WI6U1hMCYPLeB8?=
 =?iso-8859-1?Q?6oJAZ5KcJ54vaXkxAEM8mlcRvI261xMLu/fkgyB9UNjwrt/5vogLo1q2oB?=
 =?iso-8859-1?Q?0FNZ7No6bXemg8ot5oG3wtq4c9xB5LV+FYj5BiVQiAKIb+GAGOdjQXmFn/?=
 =?iso-8859-1?Q?yg3aPPz9gtgmM1oQZNMDhdZdnSWt7hAGmLdch29xPvm5SsTih3zGqJeYND?=
 =?iso-8859-1?Q?y3tfF5yMo4QYFp03Wha3gc+jFVZgJBkkfOcVgUYBB6I6a6yceFARHrUUPq?=
 =?iso-8859-1?Q?39DjB66+eTGudLoZ4+46T84LaWosQIsmd5D4XoERj1M2qqIZwZiaS/wA6J?=
 =?iso-8859-1?Q?jBsEUjW6bKpeRnOKgprtlUOVPIzhcN/pQS7Le7vWXkLRn2w/Jfa61nV58S?=
 =?iso-8859-1?Q?UJbxte3IZIgoXCv619UtOJw153SmhuaUjjg9CK0IY7QFONZfPeB5LM7Bil?=
 =?iso-8859-1?Q?nf2dbtipznZWTCmqey8Gqixnu+K0XujlzDVv5xPxfc6Dh+skvgoJjecL0M?=
 =?iso-8859-1?Q?UZvuFr1wpqdp5zbdpIyRgJEx1quHQpkjDBUP09JBQxDIzIA0tuTtyHNu9g?=
 =?iso-8859-1?Q?qMPJX3YJnZl6DVlQPfH/Us8a0ZoGJRSzcJ2tZ54mwGzspyGanZKWbrkAU9?=
 =?iso-8859-1?Q?anArDw6c7WGttGRF/dhMZt/LCu5gCF8RrUd/5EHg8gDSzwweeEHICf5s13?=
 =?iso-8859-1?Q?95niqaTux4/MACEi3hBf8TiFLkiM7Wi2s3cyyQX8O49YrYDP3Bi+fhqVdc?=
 =?iso-8859-1?Q?keieebLakPUGUD1m/osNmQ0lbHoSpEQgvO8gbqkRfBBQK8UDrRRWsbc5Ay?=
 =?iso-8859-1?Q?30gSRLoF8NZEbCcOzZG1cnCxkZGWYJhU5VaD8mq1e/S6UgkqUFydXb9E5M?=
 =?iso-8859-1?Q?8scu8uCNftgAhKYAfcONhFMxi+DYk86v2u9s/oh2JDWiBurc7GszhmX49I?=
 =?iso-8859-1?Q?OUy6ulDtr7QRn8KUGpQ8lq/kcV0VmPIaVbubil3lOXktFCiPlIV4tblZrX?=
 =?iso-8859-1?Q?uAv0cUah+CwjWIyDy7nzpP9VgBnbbWPqvvMgQovqcE1F8ivVjSwYKyEBCD?=
 =?iso-8859-1?Q?I5OHQieQuRqeULcIJowzg3j0hQVyTY3N+65EFlc1DcVRXVXayWiZs51DyP?=
 =?iso-8859-1?Q?1Fc3xCpmoV3Qo+FHakpf/kb0dXmVvbIhxp83iY8/4p9z+VdznemSnhkZF4?=
 =?iso-8859-1?Q?uGu+Asou9CM6Qp0abS2XDGNwkq0FNyx2zkgmaxNpC8/ThIgFtbWJBU+jHj?=
 =?iso-8859-1?Q?wa2yoBrEG+H6DvpV/+XdqvJnd0CFWA/8fAJMvLJy5tnuwnfmg659DAageZ?=
 =?iso-8859-1?Q?wM9dmJTu+UA209j3R/zJzYgMw2uMOg2lHQegS3+ohzxFPxUes6gaPzubto?=
 =?iso-8859-1?Q?UHpUmX4/3F7CpCZu6nijv8j7cfSeDrdSzb9FTmd4p8eSM7no74efwORRf7?=
 =?iso-8859-1?Q?vvH42A8kHxGtlIgo7sIeUhTMBviwkyg9TsaItzv5Vl2gBQxWAtXAEnYi8s?=
 =?iso-8859-1?Q?jirt+9Pn3d1Eiy8TGrcDRqd+NIVDityaB7rVg/lAdlhwah377DaExPRiam?=
 =?iso-8859-1?Q?GAYEaFu96eQeLNSEuwVFweCg1yVRIYg3MooGEJsdMShApllNAcdFQsCV8i?=
 =?iso-8859-1?Q?Y1oHMTZv3+jhhv7KnjY11V3s9Y7Vxv1mtPjkqQN+VFTCJBJWbXx7iNvl7T?=
 =?iso-8859-1?Q?NXCqrTLVT1YNk1HwuLmW588PnsYYq0wkeNKbIcX1d8zxxtUPWFVlkOqL49?=
 =?iso-8859-1?Q?WD3BQSaMH76Sy6SNs9OPJZaIgzsU7Cg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4309fbfe-a0d4-4f57-6f1d-08da27967d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:48.8642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEWhJXTh1p1UoaBWeSwWVpWuczGg8IRbntPFW3vbJHDQxSs5YZ2S5PycwwmJck2qEGs1Kr25bHM0H8NqGbHxpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: BeCu4LS1YFJr0UUSTBAq8jkzrcQWS-GL
X-Proofpoint-ORIG-GUID: BeCu4LS1YFJr0UUSTBAq8jkzrcQWS-GL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Pass through ULONG_MAX instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7924c77d213f..27567b047f2d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5760,7 +5760,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6058,9 +6058,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.35.1
