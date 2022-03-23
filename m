Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0794E5049
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243521AbiCWK2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbiCWK2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:28:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE71876E29;
        Wed, 23 Mar 2022 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648031203; x=1679567203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6fGsGJLFQNUPrG6Yd9EAaUlxoubZTQxo/jtcT6g8FQw=;
  b=Tm/8p6mwFXSYqU+1+7RW15T3Rlxzx81UjWQYBKceKHYn1V352kbR341H
   G0AKQp8jxI7RyjLTTJPxWkAsJRdqkgkCnrNYW0t0aR6BLgcuChX3BS2VY
   lCDoKEKsX9MVRBjs+aF7RxbrSNs1+rLfQkRB+vJlMTJdsCF0KqLRn7f9T
   oPIKd89RaCeioX2HBNKwwCs7wgmELYxprNyKzIlO6v9IOceNgzI7wOqEH
   RgdwV9hXzhwdFD2OaUplcgIodNi7GwC/tctUsOUfX7LM465oqadvGbvOa
   iC6iHiC5dvINRWKJibvK0LgcVWsO4UzT5xjraHZ9BAI7+RKpEPPq4YUux
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="238680204"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="238680204"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 03:26:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="544134005"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2022 03:26:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 23 Mar 2022 03:26:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Mar 2022 03:26:40 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 23 Mar 2022 03:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by4+vHJBSOfUeCm1PNBV0gQS/Z1YNJotbWjepxQFFG/kLg3YfLGRxGvYesj9Gl4wqn7YJmMRwGotUQa8Vo66KVKHYY8TelvPcLdQUoGgFCspHGqF7U/ETxaNMk2WqpRBc0MAyO9TK2y50Hpg48g8GR+N0Jd7ZrBeQq92n5m0EZD+lAPJRt+jDcZ5T7FIsVGJWtnc5e9fDufMqE/h/1yl+oghx+MB9734bPTgNxHb7ntLpsXMhXekXj5If91uFeAA9LbcaFs4t9htkpqSGvYeQJXlFbOdubCp3ufH+TF2kY51uV10/lOGwI8edmb4mKTGTvngel0bGbIEeOkVXVv3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZxxoE5v1NnJgnIzWRPQ70ZVEL7oiVUZ75f8OUkTRds=;
 b=QXcMy55rHB5zJfnmzmwbi3kkd2MoggERFPz3A6EYMPAYA0OfKBg5l8HumnQKoR2ubEremFuQTZG6Z8Y1G2T/AXkFn22RHha/bXtiIuKLoxinwo9hRgiTZZgobkQ0w/WBL8dXPYb66PAmrfbwJd8CaVkdxeF+B5BcLp/+bKSKqRu0yTgPV8QMHGQibsUAsg2jkjCT2iheuxd3kyUjSPdy0InnaZdMxQzrbYGpTja6hYhQrmLovTH5zdMWc6oJZPo8jeEkuBS+iodO2y6CDfj+x0qDrFDxi+t69vxJq/S3Rn+eAQ0Cy+iWFho4Hu+51Me9fMBgDwui84IG5JKJBjRedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by MWHPR1101MB2318.namprd11.prod.outlook.com (2603:10b6:301:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 10:26:37 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::fdae:50ef:a0cd:b1c9]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::fdae:50ef:a0cd:b1c9%7]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 10:26:37 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "bleung@google.com" <bleung@google.com>,
        "Malani, Prashant" <pmalani@google.com>
CC:     "jthies@google.com" <jthies@google.com>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>
Subject: RE: [PATCH] USB4/TBT device routers should wake up during S0ix when
 something gets connected/disconnected or a DP monitor gets plugged in
Thread-Topic: [PATCH] USB4/TBT device routers should wake up during S0ix when
 something gets connected/disconnected or a DP monitor gets plugged in
Thread-Index: AQHYPqA9gj/nefPhe0uZrTXrK6euOKzMw0/A
Date:   Wed, 23 Mar 2022 10:26:37 +0000
Message-ID: <CO1PR11MB48357FE72D34818360D2105E96189@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20220323101818.3503-1-rajat.khandelwal@intel.com>
In-Reply-To: <20220323101818.3503-1-rajat.khandelwal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: bleung@google.com,pmalani@google.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e09fdfb-916c-4ade-62ff-08da0cb79cd5
x-ms-traffictypediagnostic: MWHPR1101MB2318:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR1101MB2318A9B73DE5336BA9BBCB2A96189@MWHPR1101MB2318.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8AISVL5Bnkm9dF/Iqw1jvX3FQcsG47ZN8jDKIxjbGCyvCNs4WggZZIo/pES6d191NdZdiY9PF1u7Ol3nkVprPVCEOFzo+x0gG6OH/AovXUiYM2eBOVrabGAaDpLomw6BhTsvaCnZNIhatG9ez0PgsK5FmnqqKkd2x/rgTjniLXb5Gf3rpJXvYUT7nUIMB7lCcftZQZVK1jakEkjvieQiqVWPkPRBGFWlTPn2jlBQoM5IO0cz0+T3V/kyqxJUzt5MSDHlB99/vReEf8zi9NyYQG0o+Sf/Zmsuau5aagMdZkXVO1DwrZQbTdkf3sZyDxxgVbQocJofOikROTXHQ83lMgIPGCls0beqkVIuxGtzqaKVGdFPnhJHKnUkkzCI7iFnTgCSPv0Sz3lID8zlA4jqz8gI57R7UHO0LZixBZNzfSlRm86/D/hL7f7gTP59c05TTOu5wIREQU7Vu1tONnvz2JWWOYDTwL7Fn+G+x+wX1IJUs0iinUqmZVGer+xp6O2WIXLL04aC5wkL+agxnSE7LQS4y58J6PCyTHZmVLs9JecgrAIR3vKPolp/ATzYcyMGLRhNCZF85bi6l3876lgN+TPpFh+0TS+/76zygKXRFU9iaegK24U/FytmrmijW1P03urQN2LSAikgOC1dziAYvx+AtFYF2kheakz+Ipu/4UGsZA+5qr6YZWLuZiZ3bQrkT2qqq1H8jrxqY92LhwN1xy0CB041PJt5HuAEb3nl9VA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8676002)(66446008)(4326008)(66476007)(64756008)(53546011)(55016003)(66946007)(66556008)(508600001)(76116006)(6506007)(7696005)(82960400001)(38070700005)(8936002)(122000001)(9686003)(52536014)(316002)(5660300002)(86362001)(71200400001)(26005)(186003)(66574015)(83380400001)(33656002)(110136005)(54906003)(2906002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K3phGt0nQV8Irqn/81jAvqoRW0iba4uXNCfE6nxdFY3Ga2t/gumA4KIAcxOW?=
 =?us-ascii?Q?cv/HcH1FgUdTSmoSEpo0JjJyWJt79eFgQ7cJTmWPqnqK49UbsvJvFASPQqzl?=
 =?us-ascii?Q?IsoBEGNfZxeVJhhxFd2lwK8GLaMrociDEf41n3+0bnNC644owScln2KgpYYm?=
 =?us-ascii?Q?9EbOTRno9K/pC1LwK6XIzM9OEbgcJUOuKsmHHc4zQu8XFYEA/Ko03kYkMhXl?=
 =?us-ascii?Q?Avo66Ow3YaSZ2j5jiK0PcuSFRxNr5objiHXJxJ3jN4nRPC+6fUw/3iHm2/oE?=
 =?us-ascii?Q?G2P/K6sccLWiaMlmgu1x5h/H0bto01iYZXjhERyNp+b2hPnrifQlCE/e4tjT?=
 =?us-ascii?Q?YNWJwm6LcfsqjmAUZ+JF5/s0gFh/ae5o+8WKUzWeSmQQZRB1fdv440V4qY39?=
 =?us-ascii?Q?Mg+gm9aicW7azJW+EFlKj2HYTGhggPRI0/RsuuSchr2IRXtfwvjcK8yCDiqr?=
 =?us-ascii?Q?fG3XyVN4q3PsQaT+0ws6zSbl4fBNv1ZHU+YfhEas0x+EyNEbCIS+WFIvEiP5?=
 =?us-ascii?Q?5KK6UgzJHpNwh6ADEfx/E2qgAOnL6Bfac69Pk3po/aHt8S4QiQwFNR0ilrMZ?=
 =?us-ascii?Q?8C9IiD0XrczZE8e9qkgipAQojfwmpSRTX1nSF6GwsecdYcIjm89NwJQkEMEZ?=
 =?us-ascii?Q?ngC3OQah+DZEjtIx/+iLw4w+yp9l+wQpyuqJxmfucE1tKZnyjOGpjjQrf0bQ?=
 =?us-ascii?Q?SJtr544sPhpbxQOCriGC2CYnI/q7noMNmp5fiqhsyQh9ZA6ect202OsRSR4/?=
 =?us-ascii?Q?voASgOXaE4esvY7Fsf+ml92AHn9L7pnoRqGI2eql9EUt8mkBehRFJe4kNXHR?=
 =?us-ascii?Q?L65A/G+Rh8Pw8tlF4eyjwWv4koXWbjo/7C2N7dyCtb9PgfGDGgr5XrFkR20Z?=
 =?us-ascii?Q?IKzOdzXo43kDGJeFl9pLl+4pw7r2r9aMHpDX+7zeNuPMK3k0qCn44zZYKBWL?=
 =?us-ascii?Q?YV7Dj8IiCpk6jRpOkeB/o7U06THNPh628Yqb/ZvreWY0mZWz1u0LFq9pgeXk?=
 =?us-ascii?Q?gh3X7Tr2kmtNyo+wy5GKs3MoilTypDjGfpTjqCnxMohsc6RZosBzd95IOKQB?=
 =?us-ascii?Q?6S0tkUm17cOL68BAVccx+9+H4RnNia9mKoWaPAyHK0yqgqLHgNyz2P57bOks?=
 =?us-ascii?Q?P3kIeZPkv2wN61Gf40f4iOf4oLtWIkHBvmXtxs09XvgFm9CUm7Z8LPI5Erkv?=
 =?us-ascii?Q?pbyfO4dmW2bH+zdrOOAged6Iwy3h/+pJngr6vESRlo6zytl0pZJVuNyhUqjB?=
 =?us-ascii?Q?vB8XTA59/WnB8qZz++uwmdnBhysp2UClc0aZpzlCTsl4LvQ7IJFa+84MF6LN?=
 =?us-ascii?Q?Bcilftc1v5giz8SLjKpdSpMMKleak/9d2RSa3eUBHmE8jcppuoXoYTawwSgx?=
 =?us-ascii?Q?RtNJIu9IbFLOItgR11yJyruLKxFHCYcr+7aHMc/0DIuNR3aeKh/SffcTuQAf?=
 =?us-ascii?Q?DXGaKySVhmm/QD4E1lP8YQmhJ0OQD4VuwLgPbLYt6lADQHUWDKC8/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e09fdfb-916c-4ade-62ff-08da0cb79cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 10:26:37.5031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JN+UPA25MDL/frGbqusbwoMhegf4/evGPngUO9fxorUAzPvgLvZvXn4gILOqglp4wRnQ8XYKhFQ8dNO+VLyf4KzhFSec95TuJQ9laSjAxys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2318
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mika
@Malani, Prashant @bleung@google.com This is the patch which fixes the part=
ner issue. Kindly escalate your thoughts.=20

Thanks
Rajat

-----Original Message-----
From: Khandelwal, Rajat <rajat.khandelwal@intel.com>=20
Sent: Wednesday, March 23, 2022 3:48 PM
To: mika.westerberg@linux.intel.com
Cc: Khandelwal, Rajat <rajat.khandelwal@intel.com>; bleung@google.com; jthi=
es@google.com; Malani, Prashant <pmalani@google.com>; Rao, Abhijeet <abhije=
et.rao@intel.com>; Regupathy, Rajaram <rajaram.regupathy@intel.com>; linux-=
usb@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [PATCH] USB4/TBT device routers should wake up during S0ix when so=
mething gets connected/disconnected or a DP monitor gets plugged in

Device routers don't wake up during S0ix when something is plugged in/out o=
r if a DP monitor gets connected. This causes the linux device to not wake =
up during S0ix cycling as the host router didn't wake up because the device=
 router didn't. This patch adds a new functionality to linux.

Signed-off-by: Rajat-Khandelwal <rajat.khandelwal@intel.com>
---
 drivers/thunderbolt/switch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c in=
dex d026e305fe5d..4f8056724aa4 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -3067,13 +3067,11 @@ void tb_switch_suspend(struct tb_switch *sw, bool r=
untime)
 			tb_switch_suspend(port->remote->sw, runtime);
 	}
=20
-	if (runtime) {
+	if (runtime || device_may_wakeup(&sw->dev)) {
 		/* Trigger wake when something is plugged in/out */
 		flags |=3D TB_WAKE_ON_CONNECT | TB_WAKE_ON_DISCONNECT;
 		flags |=3D TB_WAKE_ON_USB4;
 		flags |=3D TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE | TB_WAKE_ON_DP;
-	} else if (device_may_wakeup(&sw->dev)) {
-		flags |=3D TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
 	}
=20
 	tb_switch_set_wake(sw, flags);
--
2.17.1

