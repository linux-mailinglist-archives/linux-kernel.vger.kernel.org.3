Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E744FED7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiDMD0E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Apr 2022 23:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiDMD0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:26:01 -0400
Received: from mo-csw.securemx.jp (mo-csw1516.securemx.jp [210.130.202.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A672E097;
        Tue, 12 Apr 2022 20:23:41 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 23D3NS5I015062; Wed, 13 Apr 2022 12:23:28 +0900
X-Iguazu-Qid: 34treRBDlDamgBBrCm
X-Iguazu-QSIG: v=2; s=0; t=1649820208; q=34treRBDlDamgBBrCm; m=vYboOgRUp0abN7d4O7SMDAAIDNOu2sowJPKJYOX3Vro=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1511) id 23D3NRVT011602
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 12:23:28 +0900
X-SA-MID: 2298116
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6DKqW8DY8dmd0D81aa9gkrTFJ5swbjcaoZuePplnedUMJjHWai+miE0I1iaURENKqaiyxVrelfVXhXOBQxzEa4pIt1cuXF8GjNRpJIC9oxuPJ0qw3kIDAPWAajPz8uwfmidVP4971PWqBPtJtrAjj8vwXGJ21UFA6e2evettNlyJruWzz6V+2c2WG82hZxL2Du3brKn73VvQkZZLpZZcf6sXE62TnVm+VlFUdTHAcfnNYoFq0GJ9fS73Fq1D+YSWKAsBAWzXNYX18b+HBZnas0PQw+Ur4NyfbORWyavBqT+9m+QZoLJMycZp5DNBGFTcNVYPVG9P6LpZ+6VO1PAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnixbgCOqheFILb9UuuasIitqiaWsAFTv8hccNYbtuw=;
 b=ebgtHqoGY72ChtoHKrYzMwKgy+K7IsvL3rSDhuw6Whk9duDg6YGpggs/1YDkC/1vhBKrOffars/coA3Aph4+n/u5UjozdQ8Yd8cLMII7R2lBrxmiee9M90d3pePU4Z9LTMa9VUXJbDx0Nx3sqVTivE6Jul+BZpvD2gckbzaOrTgg9QXAo3bSwXbR2RYqemQ1/jNYBZu2Hq41U8PHSYTFLNqSEO3CIPDJCikrPb3n0SpbpvaqqJatIqIMIKP5t8LoWRzmYfB3HCYACMbcsr3ONj6TbKN1qwkKkSZNchnsBFvf2Ap/GjaJPukZKoUfrkCldIQyt/oEjPThU7CzflBnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <mchehab@kernel.org>
CC:     <yuji2.ishikawa@toshiba.co.jp>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] Visconti: Add Toshiba Visconti Video Input Interface
 driver
Thread-Topic: [PATCH 0/3] Visconti: Add Toshiba Visconti Video Input Interface
 driver
Thread-Index: AQHYTtLosRvLGSMO6Ey5rYAYZA4/D6ztKrMw
Date:   Wed, 13 Apr 2022 03:18:23 +0000
X-TSB-HOP2: ON
Message-ID: <OSZPR01MB6197BCA9216B7DCB2A40960392EC9@OSZPR01MB6197.jpnprd01.prod.outlook.com>
References: <20220413010739.18489-1-yuji2.ishikawa@toshiba.co.jp>
In-Reply-To: <20220413010739.18489-1-yuji2.ishikawa@toshiba.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31de2ed8-54a6-4fe6-cf9f-08da1cfc44f8
x-ms-traffictypediagnostic: TYCPR01MB6366:EE_
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <TYCPR01MB636609E64862EB0AD0391A7B92EC9@TYCPR01MB6366.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lOL4YyiVymF04l2qtWz2I2aa+ofsuhe+fQ14vrT40nLigTCArTaR2w4arfd6DV+4V/w6tJ+3/Gi0EowjAvYXhEuEc+jRdd9MqrNubBw+u9uYDGzoGNYTmJYOHmeoh9lO0z/DeZEPv8zkNVlcgeysBzFvvDTxoXq8H1oL5HZOD2mb+aUWoEbgZEhH820eSe9rE4+aaT72/gYAfeaZiTiCNQmcqPSCxRp2Wn6CTDgYN6xyIgh2YCuTfEtDNlABrlxlj7/VM1wSAGT0Bz4alb7RvA1pMHIurHkbeOhzwq1xQo/9z2aZOxs464s4lXIf95ZioZt0oxPITFHkzCA+8CV//wN27V43/svCfdy3UE8cUkkc71j49rozZfXqGPC2OSlrG51c1UrCw3SS3k+zSTTF8ApdjN2B51ha/J6KTu/1hrOxTineTAM40SkhTBdzZys1kZBCjcwGurSt4IcUWg4YOme50k1tOX+3dDps4N8h+keG8YClbCQXtL6EOD3JL94ep5kFlZMIJN9hhFcU3eT3QKKFxYD3AOR2h0jePObTNDWleZ9qNt9LhUlTJbWFj1Y/GPRYAR2s/rT5DmDXbLk8KWft9cuQt6FxgCvT1zu3au+ON2EJpaEp2kSwaafRXpNEZdJ5s2PIJxFcsSkY/prnebpz6zYlf4ovNsmBh/y+8l6d72Pz38Ck8w8BIy+zBE7epOdA9Jtcop3ELyAbW/Je0Rh6dAVK3+xL4m8PMgFRhgKB6UjmjB5yCgEb61Y+YjD3MhIFbH+CeARFf2ubuTgn3UQF1cya0/PsQiRq2fnDVhs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6197.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(33656002)(5660300002)(54906003)(7696005)(186003)(26005)(508600001)(55016003)(8676002)(66446008)(66476007)(66556008)(64756008)(122000001)(66946007)(76116006)(6506007)(38070700005)(4326008)(52536014)(9686003)(6916009)(83380400001)(53546011)(86362001)(8936002)(316002)(966005)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?a3VORVBwY0dkeFZzc2sxVTErTVBoNzkySzJHUWlCNnBmNU9jaXA5azJs?=
 =?iso-2022-jp?B?SkFsV2hjMmRnNnNXYUo1Si9VRndCbitRT2V3ZkVMbjExT0NhSXVtOGJ1?=
 =?iso-2022-jp?B?ZGxncWlpbUE0V25FMW9jTFN3MDJuTHJDT0V1d2c3TndITm5PN2kra0ly?=
 =?iso-2022-jp?B?T0hIOTZzUDI2Zm9DOHdOTXdjSENDM2gzNW8rQnpJeC9uQ2w2ZndUREQ1?=
 =?iso-2022-jp?B?MUlhbVBQeHpOeDZTaGYyS3VlWCtOWjlDRVFwMFh2TytNMEllbS9qY2xK?=
 =?iso-2022-jp?B?bE5DNnJDT3RlZGQyanEzUW9BMHFhVlBhWk1YeUx6dmtucFh4ZEcvM3B5?=
 =?iso-2022-jp?B?WTRkb3czcXVBOVF0UDhJMUhYNGNmVnhrRTFNLzhvd2tqWW5aRjl4ZmFE?=
 =?iso-2022-jp?B?VGNIWUNmVEFreFlyMW1ZeGVWay9nck84Wk9kc1ZoR1pwL1FBMGtMalRK?=
 =?iso-2022-jp?B?MUZGQjl4bnhONmJ6L1FTZEJEZjFlc1FGdlZhbGphNnpseE5IMGVsYnIw?=
 =?iso-2022-jp?B?TW9ySDRVbkoyU2FOd2NBd09iTkFHRURFRWc5OXRPdi8wOGM0Z1BlaHJF?=
 =?iso-2022-jp?B?MTZYOXhwUUYxa2hrNlVYajdCT2xCUi9kY2xQTld1bElSOVNWUmhqQnhp?=
 =?iso-2022-jp?B?dlN1eVhNcGpnQURabmovZWd3N1JZK0diSmJVOFRXc2VyZnU4NGlMNDls?=
 =?iso-2022-jp?B?Y1ZCTHlua0JMWGVnbVdZNHBtcG8rejByODYwdnR5N2hDQWdUam05MVJr?=
 =?iso-2022-jp?B?cllEdTR6aUZLV0RTSVpZd0xacFV2UmRaUE1UYWFsZXZnRkYvZE9oRlow?=
 =?iso-2022-jp?B?YjdzckNlUVVQQzh1TVB2ZFR6eTczTFE5NVR0OE5GTHliSDk2aW5HeGNP?=
 =?iso-2022-jp?B?ZUVKQmNFQjFFenh2VndNOFFhdXAxZWEvaC9uVHJpNGJPd2ZIUTlGOW55?=
 =?iso-2022-jp?B?WEF1Z3hPVnZEdE1TdFd1c3BsK1R0NExBeG9wQjlNZWlMeFA5bVNGNDU5?=
 =?iso-2022-jp?B?bWxzaUpKUkRzV3cwVlpDbUM0STFPL0dyejZNODB0RlhqSGxoQmo0aDNq?=
 =?iso-2022-jp?B?V1RyZjZEVXlNQ1h2UjlqdEZ6aDFCTHdNb0hXcGZEVTVOK0Y0TTUxSTZT?=
 =?iso-2022-jp?B?Uzd3cGl4YUhJckVaS1JRbnpmT0ZiYW12dzVzZEhtUURhcUJnT2xHSlBV?=
 =?iso-2022-jp?B?K0Y0R2FOTXBJRTRyZmxjZ0hqbWxQOHA4U0c0LzFaTlVuSSsyREp3R1A1?=
 =?iso-2022-jp?B?TE9sYWhxT2RFVk5GaDZjWW1KTEhPT2pyWHNmZlBJbStTa1ppUGJpZlE4?=
 =?iso-2022-jp?B?b2h4UDcyOFZiZFBwVlVVVm52WGdQczFqakpmUTI2REx0MXdocG1CUkp4?=
 =?iso-2022-jp?B?SXMwWW5zeGRJUUtNZFByelQvaEIyNFhkRVNiZGVDMjhFUnFrWDlHeW1E?=
 =?iso-2022-jp?B?NTI2VmFPZGZWSWYrRUFJSVV3UkJVQXNTUWo2ZFcwUlUyay9EWkhPTURE?=
 =?iso-2022-jp?B?K0hKWXV6Q1dWMGdrS1NLL21yRkZ5cDRuUnZvcVI5U0U3a01oMEFoTk1v?=
 =?iso-2022-jp?B?akxla0RlMWRjd1hYbG5yVGIwbnRlM0JrVzRrbkZmeVdhUTZUMUd5TlY2?=
 =?iso-2022-jp?B?K0FLVGNmdUFzcy9mUHIxUVY3MnozRTcxS1Zib3N6TW1qdzhXL3JDbVds?=
 =?iso-2022-jp?B?d2MxVyttbUJzcjF1NjMrcExsR1hqcUJxUytnREVrbWRHeW9ocjBiaEla?=
 =?iso-2022-jp?B?M2R1dVVrQ3I2OVg4QnBvbU1EWFVSRzQ4NVlRQ1RKL3hVSFc1cStJRU9Z?=
 =?iso-2022-jp?B?dzFrSkhld3Bnb1Z4c0ovbnVkbDg4cFBVOWFvQjlUM2tGcG5sdXFMemdS?=
 =?iso-2022-jp?B?RStJeEVEY1BTcnR1Y0dTMGZCZWRKSTI4Z0s5N2VWSnp6RzhuK0dIU0Z3?=
 =?iso-2022-jp?B?YURKYWRDcDBMa202QjhXKzlkaFJnY0Z0VlQ2bHBjVE5YMENwdDRzYWtq?=
 =?iso-2022-jp?B?T0FKV1cwUG5FdnE1SDhBdVlPdkkvZnhrS21GTTA3OEtZMFRxajNTYi9S?=
 =?iso-2022-jp?B?QU1DcDA3TFkzWWNMckZJcTJ0bVpSUVJQdmxFSlp4dFJ1UW1Ga2NZbXBJ?=
 =?iso-2022-jp?B?MThWN1pzQk1TNDY3WVJqZUZVbFgzR05nU1dPUko5bTYzWWJMMVVKbjVj?=
 =?iso-2022-jp?B?ckVRTGxCSEdSeEJGNVBJTmt4aW40anorZDhqNHFpaGlOZVp1eHRqZVIv?=
 =?iso-2022-jp?B?MG1paGlxQVhqOUVZT3JRUm82blNrNnBCK1JNY0NkRzdWSU5jQldOSVlE?=
 =?iso-2022-jp?B?RXI3ekdDZHBacGpqcDlrdjNkZ2tkVzZpNDB4Mkdyc3VDbGJnRWZJRlZI?=
 =?iso-2022-jp?B?eWtISHBYa0FNV2NsT3cxcGdOazMwOTJMUnl0MGNIU29ZYzhQV0JuVzRJ?=
 =?iso-2022-jp?B?dFNWcThGWTdYS045N2hIWmI1Z2E1S2dsc3VRNWdzT0hTSFhWSVY1VmZZ?=
 =?iso-2022-jp?B?eFlQOHZSaXdxMElrMVpzdTgvRDVIMHNqOHpUSFdPR0NrSW1tMTVPTnlN?=
 =?iso-2022-jp?B?NkgzUjFwMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6197.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31de2ed8-54a6-4fe6-cf9f-08da1cfc44f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 03:18:24.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8oRtvq0hTQTeZyOY0OLt95s0JiZx87iNrMM0WhAf6liaCTXA++FJP6idVrB28EbbphLW8Rsl44X4+kUFHPEhccH+wHX/62HCo4yHZnAKF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6366
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I withdraw this series of patches because the size of PATCH 2/3 is too large.
I'm going to split it into smaller parts and submit again.

Best regards,
Yuji

-----Original Message-----
From: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp> 
Sent: Wednesday, April 13, 2022 10:08 AM
To: iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開) <yuji2.ishikawa@toshiba.co.jp>
Subject: [PATCH 0/3] Visconti: Add Toshiba Visconti Video Input Interface driver

This series is the Video Input Interface driver for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation, device driver, MAINTAINER fiels.

Best regards,
Yuji

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

Yuji Ishikawa (3):
  dt-bindings: media: platform: visconti: Add Toshiba Visconti Video
    Input Interface bindings
  media: platform: visconti: Add Toshiba Visconti Video Input Interface
    driver
  MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface

 .../bindings/media/toshiba,visconti-viif.yaml |  103 +
 MAINTAINERS                                   |    2 +
 drivers/media/platform/Kconfig                |    2 +
 drivers/media/platform/Makefile               |    4 +
 drivers/media/platform/visconti/Kconfig       |    9 +
 drivers/media/platform/visconti/Makefile      |    9 +
 drivers/media/platform/visconti/hwd_viif.c    | 2233 ++++++++++
 drivers/media/platform/visconti/hwd_viif.h    | 1776 ++++++++
 .../media/platform/visconti/hwd_viif_csi2rx.c |  767 ++++
 .../platform/visconti/hwd_viif_internal.h     |  361 ++
 .../media/platform/visconti/hwd_viif_l1isp.c  | 3769 +++++++++++++++++
 .../media/platform/visconti/hwd_viif_reg.h    | 2802 ++++++++++++
 drivers/media/platform/visconti/viif.c        | 2384 +++++++++++
 drivers/media/platform/visconti/viif.h        |  134 +
 include/uapi/linux/visconti_viif.h            | 1683 ++++++++
 15 files changed, 16038 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
 create mode 100644 drivers/media/platform/visconti/Kconfig
 create mode 100644 drivers/media/platform/visconti/Makefile
 create mode 100644 drivers/media/platform/visconti/hwd_viif.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_l1isp.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
 create mode 100644 drivers/media/platform/visconti/viif.c
 create mode 100644 drivers/media/platform/visconti/viif.h
 create mode 100644 include/uapi/linux/visconti_viif.h

-- 
2.17.1


