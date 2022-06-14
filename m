Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999B254A72D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiFNC52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354888AbiFNC5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:57:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A13F30A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655174878; x=1686710878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ON3z1DqyQG8DRBlv5nsnPxM6fVsrn0TbGFzYjFtPjLs=;
  b=RVBqLn1HcXYTtb/UrcmEnVbn5i6ymP1TX1AOXX3qqKnJSWd8xAd/1YRM
   XGFL2hkoqclaN82w3rBWBIDoN55xDXUolXIc0LEVBzdjc843nnqCQb1KJ
   s4072+rS6aFUE8zJgiOsX+xbZvBEh16ZDoeBX0g0T1Mz0w/MQG1GqgqCB
   UopqLbQEM/0JwKcSB65mjXOP7M/XWZE/+pSn+o/K6vU2PAEYAaWj26nwl
   iccFB3utMWqC1GowJiD3OWZWPoAnEGI6So6xCRTG5HY13ctUxo7DLHiBk
   wmYxxSoaz5RizaVsfO/rdd/PyE26MFCzL9XvSN8WxGLKvKl4Y8rObI0ch
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279202754"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="279202754"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 19:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="588163675"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 19:47:57 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 19:47:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 19:47:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 19:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vxea7vWENeey7RKHOlSecMCuAxtimJh0QkdqLH35kKWramV9VCvHQngBD7+RjZwW2ZrBTHSGBqWi/R0pMSFJbXbrAF4E3PKL7RDPUqnG20XV/C9NcudwtbBISqpAWGpk09m/ge3XaMWwXPI3XxCH9LzqGDIhMf36qpN8/Ah1m9SzVCku4dXs5sM9bRa2wIu4XGqjYt7yWAUKoNDFb6euwN6yRXY7c6NYHj6P1w4HWC6ZgX/OxTOM+yQxRuwcFEPdVUO4Qo3M6qsyi9CFzpd2UkBb84ggiDTkX4b0ayzArXPgmsqhWE+k3dTd1EL4VLA2bS9FASv9UFw1yl17vtc0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUhsrO4YJwn4Sz0eM+ZW+VZUKq6+MHcYVZG0ryUmZwE=;
 b=PzoJfOg2IMF2G4+WXjknieLOibH595TYARytwGmwK1AoPCt6sk4EHGv0Hbncq2BY6/8d5YTJ8qvb6JaL5oS6+Chx6asyqD2vOUdRTqQIbqeWQDd5Ly93IKoLnRkx+6XjBrDBg0gVP2GuTcywGnxN8/kEJjMmQCzmh/RACuHEpXv/r4gwvZ3Uq973rjnx6+HzBYNbj8FSAz1RkAllN1BEhbIpHpmYf9IlJIHelqQHvarmLm4hoKMZYKlNmLnLtM/bu+lLcWsC4W8L7MBEzvzEe4h+ve1xwXMmSD220p3lcxelPAYS1aqFDrly3ZoEhTU0jtrs8XmfJJnRpg26BMvgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM5PR11MB1354.namprd11.prod.outlook.com (2603:10b6:3:15::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Tue, 14 Jun
 2022 02:47:55 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 02:47:55 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Topic: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Index: AQHYfnKnPcEG5KPSqUKTUzyVmEvcrK1MN1mLgADFmMCAAHlEgIAAboyggAAbjYCAAAEvgIAABfiAgAAHecCAACTOAIAAAWGg
Date:   Tue, 14 Jun 2022 02:47:55 +0000
Message-ID: <PH0PR11MB5880D72E86AD3C5E9395B0D7DAAA9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220613233753.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <202206131639.DBA0A8D@keescook>
 <20220614000329.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880C6814BA88CD660610344DAAA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220614024158.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220614024158.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7473997-0ac7-4df7-19c1-08da4db048a0
x-ms-traffictypediagnostic: DM5PR11MB1354:EE_
x-microsoft-antispam-prvs: <DM5PR11MB13544740220DC04D58BB7EADDAAA9@DM5PR11MB1354.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFrcwjBB8O8yW6tHk9ReKgnIArZ1v4XJL8EtCwQ7ENZqKxMBVnZ8Yot9hzI4YW1ByMpsu3I58hwkJmndUD9NGAZn3P44ArBeO66yiqCXD/77h4IUrjy7HvN92i0tFhFNj5Sw5lc6JTj5TrYOtpgY0l/nJzQAGKMF/XEN9CFMa9Iwvh66I+XsHszUI9/uaLRHldBkWaZhMzhZdYb30IskzxnlJ5dV9lcX/LICsBqezf/2kR1LrGWeOoDhm+fZ+sHHnuwHRnTp6qM8yC2hWAUPywgY+6Qe+Ou727Yd1zSQqDBVYna8tJXMitM+ynVQDf9gDqS5ajm1UEN4UVNyyxWvkFayIcofavGQGha1/vgli0j6oX/wWUcs8DgKYanXHAb7UvxmYZGcIG7nX5ftarEwPitHrtMIVTczoreu8+7FbOdGHAnjjL1IDWHjE/WB8s34sKxGHLdv3MzjhrizCCgAk03iYm6JzoPJJryTvkmYmddPsnvUl4blw2vMPZpe+0rPt2HIR9mv0i+0xFGVktVD5yQn54GZ5SUouJJQitbPVhu+P/joHaWsYpf3CIGCBJrGm/A1TUlLryFCuydvrXefxJ0TpXAcr5tPciBYn2KUBfDJkTpMf5gMaYaxpvXqJNaSWyNr+jW1n7ivIVoWuJPPH5FCzRvWB9xMT2+TolNxWvUy4ozxM8hDU2VYD/llOHQI9KYijNtDvnl4HBRIzgVvHqKgcmK/iDRo9YWHEEsHebsIHCgIFo5RpX5hKYWMfk/miYUCXtqgu223t1uhhkr0O/hytclxAWq43uvAYn9m8SSpLtRlTF8PLP85bt6lFQl+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8676002)(33656002)(64756008)(86362001)(55016003)(66446008)(4326008)(82960400001)(122000001)(5660300002)(66556008)(71200400001)(66476007)(66946007)(966005)(316002)(2906002)(8936002)(52536014)(38070700005)(508600001)(186003)(76116006)(6916009)(54906003)(6506007)(7696005)(45080400002)(83380400001)(9686003)(38100700002)(26005)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s6tmjG7ZWI2SqgYR3+Jf+xkTqxWMFNJWnOom+m8m2UXVoVNLRmxj7Z5ZiQdX?=
 =?us-ascii?Q?R7M6CQjTh9okk5v8Iu0Torl81Gx0OWYDvsgu4WyybGKwZVE4A9CTqwB42LlJ?=
 =?us-ascii?Q?GYLt/yP83n39S3N34gy8iL3MeRC+wvmIey/ADWvNEp173h072sVd9V1kwNYW?=
 =?us-ascii?Q?OrAsJM5YRH1jVtxnwapHbj47OgFeqYOwdqR5N0HNpIafzUQ+VQVRNLyPTSHa?=
 =?us-ascii?Q?cEtTPb1m/9blKIHoMgGuRoRB+tNR9WfYPJuITb6l76ECwuvuThwB8acIRMyA?=
 =?us-ascii?Q?nWiNJNQPmOzYgiv+rzTiT1AoJeG15FRhWvzTBJC+4gvQ3IFdUfEo/qBSk1st?=
 =?us-ascii?Q?JbAYaOwbispdBAzDpeH4iDi7KL482EOfp0vQmPhpHDd2b8OMZ5D7Vcp0Iw6u?=
 =?us-ascii?Q?Lst8jp0g9dG6WaQwK1g8PBamioc78xwXAb05XxDy3GGsYTTH6Sf62EJIfJRU?=
 =?us-ascii?Q?SsQWUeSRdWPKCYIjmkS8vbvO/SMwQuSCljRNZrByNqRQr9a9KPTye1OSsqck?=
 =?us-ascii?Q?mgY2UZ318MsS/ITRY1XZJiv+DUf6PXp7otw/cLpC+Z3mnEIbhzp3VW/oIOLJ?=
 =?us-ascii?Q?W82Putf21qfBevmkDHwSLT9bGUlsZ/z3Z0cR+yjABF1q5y6JuqDbgtoxoJnt?=
 =?us-ascii?Q?uJHlisrh8//ijM0eMEMBXWxWc14sGU9X3zxruqzq3v9LFtEaAzJReIpqU/1X?=
 =?us-ascii?Q?Sjx+oQhMUkScKkNIeTlpjb+X0bxqSPaPnl4asdlGl9sJ8ZCa3CYdAauf5853?=
 =?us-ascii?Q?LlDYoxFyZ3OHRfbZ4RQf0EZWgL+4XIaQ5muGDTN7zAsdcr6OKazj0zOYFyYg?=
 =?us-ascii?Q?yp3pFIm25nUk3Bvi2Xi1Uugtd9uwWmuKPirWP5pgRfv0m/4xhAnqjCXX4wPQ?=
 =?us-ascii?Q?nx8zAfI8qK7toaHBe2TblzHu1IwHra9gNgX+XN0UUOytWiDxSlD2+OFAwDYB?=
 =?us-ascii?Q?sJb4HToQnfQQb5pNYlVi8aP0kjuMyBPwmv2IawQUbxBA1TLBWr0VNphUZpjf?=
 =?us-ascii?Q?p0hotSTeCfikTw4ctIY5blZx+3VGRY7hUbRD2M5LJxyPDi3xT240981mHLuh?=
 =?us-ascii?Q?gK0IKXfDKzbBgI7tlyEFZQSWi0eyTQLzAXt8kAWSTsYvNAjHKjoQaGTHgzEm?=
 =?us-ascii?Q?qX5c6tRjU+uf/nQ5pzugHKEIIHteHSfYTyrbH29tdqiRwtMIZxJiC8JvuS7w?=
 =?us-ascii?Q?MqzOeW+J3q9YQAwc3XQRgvmQTdRqXFwkedn5nlNSWHyHTDfHXq3rPTXQ147X?=
 =?us-ascii?Q?NY7wr76agqDrviJ4gblWfnBgZMfbppDqN+Mh/8crIBX+RlbiGacDOKnGkUTF?=
 =?us-ascii?Q?yw3vO+kTaih3wYDosd9oG+cKTeVDW4vLr4NdPPBCL81zOGoY+gdfXoMoaWbj?=
 =?us-ascii?Q?h14DgKH7pZKFtTf41ddQlsphewtYQoBcD8BSb5V/swB4VZyzstMPN8KHI9cS?=
 =?us-ascii?Q?NcOkK3Ay2FrgTd/SSNxDUwnFTz7RRv2AOaimCxE0zIBWOgcLtI7UayK/G3As?=
 =?us-ascii?Q?IXHxFgOqMhP9gh/zRA3NDmqiPjRjopp82gA5blepWw41eI3eZIqYb/G9LYV7?=
 =?us-ascii?Q?n5G/+6VEOspzVwf+KKmzZGY8NYH3SL2n3mvvs9vh6jDYRET63F3jqFZcABQl?=
 =?us-ascii?Q?qeCQt14HkQSR6mgKsoBA5tr8e4r3/5bYaNthklkMhRwWmyMS2CH1TSUBicku?=
 =?us-ascii?Q?X+XwEVvBxBTUZzCMmR4/wS6vyACX0Fvcg9jDb+qZg4lIw1j01IaT8VEaUx9x?=
 =?us-ascii?Q?A6fQkGL9YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7473997-0ac7-4df7-19c1-08da4db048a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 02:47:55.4068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jo1Kd9bHjvvzsazdS/+YIPA9QP13Nh8EUEQmrGGCRKCbdnet/3yxaMK94L9eyyVTA71gslLpUBz9r0JvLP5wzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1354
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 12:52:23AM +0000, Zhang, Qiang1 wrote:
> On Mon, Jun 13, 2022 at 04:42:07PM -0700, Kees Cook wrote:
> > On Mon, Jun 13, 2022 at 10:36:07AM -0700, syzbot wrote:
> > > Hello,
> > >=20
> > > syzbot has tested the proposed patch and the reproducer did not trigg=
er any issue:
> > >=20
> > > Reported-and-tested-by:=20
> > > syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
> >=20
> > Looks like the patch solved the reproducer. :)
>=20
> >For one of the two possible ways to make the bug happen.  ;-)
> >
> >Still, good on Qiang for identifying one of the paths!  Not just anyone =
can do that.
>=20
> Thanks Paul, yes this patch can solved the reproducer and I also test it.
>=20
> I compiled "bpf_test" according to the c file in the following link
>=20
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D148207bff0000=
0
>=20
> Not apply this patch, this calltrace reproduce
>=20
> root@qemux86-64:/# ./bpf_test
> ^C
> root@qemux86-64:/# dmesg
> [  147.017232] ------------[ cut here ]------------ [  147.017234]=20
> WARNING: CPU: 3 PID: 21586 at kernel/rcu/tasks.h:1664=20
> exit_tasks_rcu_finish+0xbf/0x100 [  147.017245] Modules linked in:
> [  147.017249] CPU: 3 PID: 21586 Comm: bpf_test Not tainted=20
> 5.19.0-rc1-next-20220610-yoctodev-standard #204 [  147.017253]=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=20
> rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014 [  147.017256]=20
> RIP: 0010:exit_tasks_rcu_finish+0xbf/0x100
> [  147.017261] Code: 03 00 00 85 c0 75 59 f0 83 44 24 fc 00 49 8d bc=20
> 24 41 03 00 00 e8 21 09 2b 00 41 0f b6 84 24 41 03 00 00 83 e0 01 08=20
> d8 74 11 <0f> 8 [  147.017264] RSP: 0018:ffff88810ccd7af0 EFLAGS:=20
> 00010202 [  147.017268] RAX: 0000000000000001 RBX: 0000000000000201=20
> RCX: ffffffff897ab52f [  147.017271] RDX: 1ffff1102181d7c8 RSI:=20
> 0000000000000000 RDI: ffff88810c0ebe41 [  147.017274] RBP:=20
> ffff88810ccd7b08 R08: ffffffff897ab510 R09: 0000000000000000 [ =20
> 147.017277] R10: ffffffff8c407bbf R11: 0000000000000000 R12:=20
> ffff88810c0ebb00 [  147.017279] R13: ffff88810c0ebe38 R14:=20
> ffff88810ccd7b78 R15: ffff88810ccd76b0 [  147.017282] FS: =20
> 0000000000000000(0000) GS:ffff88815a000000(0000) knlGS:0000000000000000 [=
  147.017287] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  147.0172=
89] CR2: 0000000000000000 CR3: 000000011ac16000 CR4: 00000000001506e0 [  14=
7.017292] Call Trace:
> [  147.017294]  <TASK>
> [  147.017297]  do_exit+0xe9a/0x13a0
> [  147.017305]  ? mm_update_next_owner+0x450/0x450 [  147.017309]  ?=20
> lock_downgrade+0x410/0x410 [  147.017313]  ?=20
> lock_contended+0x790/0x790 [  147.017317]  ?=20
> rcu_read_lock_held_common+0x1e/0x60
> [  147.017324]  do_group_exit+0x71/0x150 [  147.017329] =20
> get_signal+0x1319/0x1340 [  147.017334]  ?=20
> futex_wait_setup+0x180/0x180 [  147.017341]  ?=20
> exit_signals+0x4c0/0x4c0 [  147.017345]  ? futex_wake+0x29e/0x2e0 [ =20
> 147.017351]  arch_do_signal_or_restart+0x9c/0xc60
> [  147.017357]  ? rcu_read_lock_sched_held+0x60/0xd0
> [  147.017361]  ? rcu_read_lock_bh_held+0xb0/0xb0 [  147.017367]  ?=20
> get_sigframe_size+0x20/0x20 [  147.017371]  ? do_futex+0x1a2/0x240 [ =20
> 147.017375]  ? __ia32_sys_get_robust_list+0x240/0x240
> [  147.017378]  ? __context_tracking_exit+0x91/0xa0 [  147.017385]  ?=20
> lock_downgrade+0x410/0x410 [  147.017390]  ?=20
> __x64_sys_futex+0x125/0x2b0 [  147.017393]  ?=20
> rcu_read_lock_held_common+0x1e/0x60
> [  147.017399]  ? lockdep_hardirqs_on_prepare+0x13/0x230
> [  147.017403]  ? exit_to_user_mode_prepare+0x151/0x240
> [  147.017409]  exit_to_user_mode_prepare+0x16c/0x240
> [  147.017415]  syscall_exit_to_user_mode+0x1e/0x70
> [  147.017419]  do_syscall_64+0x50/0x90 [  147.017423] =20
> entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  147.017427] RIP: 0033:0x7f780e668fbd [  147.017431] Code: Unable to=20
> access opcode bytes at RIP 0x7f780e668f93.
> [  147.017433] RSP: 002b:00007f780e55bd48 EFLAGS: 00000246 ORIG_RAX:=20
> 00000000000000ca [  147.017437] RAX: fffffffffffffe00 RBX:=20
> 00007f780e55c640 RCX: 00007f780e668fbd [  147.017440] RDX:=20
> 0000000000000000 RSI: 0000000000000080 RDI: 000055ed9f3a8088 [ =20
> 147.017442] RBP: 00007f780e55bd60 R08: 0000000100000001 R09:=20
> 0000000100000001 [  147.017445] R10: 0000000000000000 R11:=20
> 0000000000000246 R12: fffffffffffffeb0 [  147.017447] R13:=20
> 0000000000000000 R14: 00007ffe5dcf20a0 R15: 00007f780e53c000 [ =20
> 147.017455]  </TASK> [  147.017458] irq event stamp: 0 [  147.017460]=20
> hardirqs last  enabled at (0): [<0000000000000000>] 0x0 [  147.017463]=20
> hardirqs last disabled at (0): [<ffffffff896b5990>]=20
> copy_process+0xe30/0x35f0 [  147.017467] softirqs last  enabled at=20
> (0): [<ffffffff896b5990>] copy_process+0xe30/0x35f0 [  147.017470]=20
> softirqs last disabled at (0): [<0000000000000000>] 0x0 [  147.017473]=20
> ---[ end trace 0000000000000000 ]---
>=20
> Apply this patch , this problem not reproduce.
>
>Thank you very much!  May I apply your Tested-by?

Thanks, I am very willing

>
>							Thanx, Paul

> Thanks
> Zqiang
>=20
> >
> >							Thanx, Paul
> >
> > > Tested on:
> > >=20
> > > commit:         6d0c8068 Add linux-next specific files for 20220610
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/li=
nux-next.git next-20220610
> > > console output:=20
> > > https://syzkaller.appspot.com/x/log.txt?x=3D12d068eff00000
> > > kernel config: =20
> > > https://syzkaller.appspot.com/x/.config?x=3Da30d6e3e814e5931
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9bb26e7c5e8=
e4fa7e641
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bi=
nutils for Debian) 2.35.2
> > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D147f47=
c8080000
> > >=20
> > > Note: testing is done by a robot and is best-effort only.
> >=20
> > You can see the dashboard link above for testing details...
> >=20
> > --
> > Kees Cook
