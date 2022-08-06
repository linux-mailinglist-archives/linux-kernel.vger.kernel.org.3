Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24458B3A4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 06:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiHFEC5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 6 Aug 2022 00:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiHFECy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 00:02:54 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Aug 2022 21:02:53 PDT
Received: from lvs-smtpgate1.nz.fh-koeln.de (lvs-smtpgate1.nz.FH-Koeln.DE [139.6.1.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A987813D28
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 21:02:53 -0700 (PDT)
Message-Id: <178efe$25k5a6@smtp.intranet.fh-koeln.de>
X-IPAS-Result: =?us-ascii?q?A2D//wB/5u1i/9LeBotaHAEBASsLBgEBBAQBAQIBAQcBA?=
 =?us-ascii?q?RWBTwIBGggBgRYCAQEBAUwBAQEBgROBLAEBK4ROg0+ITyODIAGBKYJ1ixaBY?=
 =?us-ascii?q?wUCgiuMWQsBAQEBAQEBAQEJEgIlCQQBAYUEAVMBAQEBB4QfJjcGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEIAQEBAQYEgRyFLzkNXwEBAYEMNAEBAYQQAQEBBgEBA?=
 =?us-ascii?q?StrIAIZDQJJFkcBAQEBgkZFAQEBgiUBATMTojuHYYExgQGCKYEmAYELgikFg?=
 =?us-ascii?q?nKBFyoCAQEBAQEBh22QXIEPAQKFGB0TglIEmCkCAho4AzQRHjcLA10ICRcSI?=
 =?us-ascii?q?AIEERoLBgMWPgkCBA4DQAgNAxEEAw8YCRIIEAQGAzEMJQsDFAwBBgMGBQMBA?=
 =?us-ascii?q?xsDFAMFJAcDHA8jDQ0EHx0DAwUlAwICGwcCAgMCBhUGAgJOOQgECAQrJA8FA?=
 =?us-ascii?q?gcvBQQvAh4EBQYRCAIWAgYEBAQEFgIQCAIIJxcHEzMZAQVZEAkhHAkfEAUGE?=
 =?us-ascii?q?wMgbwVFDygzNTwrHxsKYCcLKicEFQMEBAMCBhMDAyICEC4xAxUGKRMSLQkqd?=
 =?us-ascii?q?QkCAyJuAwMEKC4DCUAHCSYsPQUFRz4PlnmCEIE4AjCHC41Cg2UFilagWwcDg?=
 =?us-ascii?q?1GBRAKTfowogkaSdA4EkX0JhW+EdowSp1iBd4F/cIFuCSWBG1EZD5ISil90A?=
 =?us-ascii?q?jkCBgEKAQEDCYxlgQqBGAEB?=
IronPort-Data: A9a23:kNypR605IRyzeO/dI/bD5ZF3kn2cJEfYwER7XKvMYLTBsI5bp2FTz
 TYXW2+AOqyMZGHyet8jOdvn/EIBvpSBmNdmTVdr3Hw8FHgiRegppDi6wuUcGwvIc6UvmWo+t
 512huHodZxyFDmEzvuUGuCJhWFm0q2VTabLBufBOyRgLSdpUy5JZShLwobVv6Yx6TSHK1LV0
 T/Ni5CHULOV82YcGn4Z7auFtCRusJza0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatU88tqBe
 gr25OrRElU1X/saIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt/dg+
 ORV68KPcAEoAonWsdgQYxpXLxgraMWq+JefSZS+mem65BSbXSCq3e1oSk82eI4f9+JxR21Dn
 RAaAGlWP1bdwbjsmvThE7EEascLdaEHOKsas3pjwDfLDPtgXY3fX6HHzdRRmi0qwMtJGJ4yY
 uJGMmI2NkmdO3WjPH8qDrIFkMyahELBWA1063/Kv4k2vCvMmVkZPL/FaoOOI4faFK25hH2wq
 mvA/mn9RBodMsCW4TqC7nelh+uJliT+MKoZHaex8/NvikCa2mEWARwSfUqyof6+zEW5Xrp3I
 EUO8y8jqKIv/VCmS9D8WzW3pXeFulgXXN84O+Yz8giIx6/e/g+FC20NTzppaNs6scY3QXoh0
 Vrht9LlCDhkt+S9SXWB876VqXW5Pi19BWsDYzIUCAgI+d/upKktgR/VCNVuCqi4ipvyAz6Y6
 y+DqjAzgbpVy4gj16Kn+FnGh3SnoZ2hZhY4+kORGEqk6A1jbYKoboDu7kLUhd5YJoGfXB/H+
 lAelsSe5fxIBpaI/ASIQaNLWpmq6uyDPTmahkRgd7Es+T3rvTiLcoVApj1zTG91dIBCUTvoZ
 lLPowRX5Y8VMHbCRfYrPN3tW511l/alTI+/DKuRN59BY4Q0bwKB8GRjYEeR2yXymU40nKcwf
 5OaWcarEXMTCKAhxz2zL88M1qIxwyk/wUvTQoz+xhWjl7GZYRa9UqodKFyUcqU166aNoQP9+
 dJCOsuN0AkZW+r7CgHT7I0eGlADN2QgGZfwpMF/dumfJwNnHCcqDPq56bAofo1hluJPn+3F+
 nW6ck9f1F/2hHmBIgKPAlhsYbn1XJt7qXM+NAQjJUyp0HVlaoGqqq0FH7M4dLM99eFni/ExV
 +MEcMioAvNTTz3G/3IWapyVhJRnXBusm0SUOEKYjCMXZ8Q6HVaQopn6Zg2q+DgISCS38Mg5r
 rmmkA/WKXYee+h8JOHHWMO3kQ2OhH4cpMZodnfFEtpcRHy5peCGNBfNYu8Lz9AkcEuel2XEi
 lnPXX/0tsGQ+95voYahabSs8db1Q7oW8l9yQjGz0FqgCcXN1kaOqWOqeM2PeTfSUm6cFE6KO
 L0LkK+U3BEvulFQr4o0KbZqy6972Nb0u6daxwBlFR32g7WX5lBIeyfuMTFn7PEl+1OgkVLet
 4Lm0oAy1U+1EM3kCkUNAwEuc/6O0/oZ8hGLs6lkfx+mvnQupebdOam3A/VqoHMDRFeSGNx+q
 drNROZMt1PXZucCbYfW3nEFrQxg0FRdCvl47fn2/7MHeiJxkwobOsyNYsMHyJ2CdslXOUknO
 Xeag7DZjLRBwEXZdXcvBxDwMRl12vwzVdEj5AFqGmllbfKc3qBthE0Aq2RpJumXpz0eu99O1
 qFQHxUdDc2zE/1A3aCvg0jE99l9OSCk
IronPort-HdrOrdr: A9a23:5CeYvK0wtCOCoOLOpOK2oAqjBKUkLtp133Aq2lEZdPSdGvb1qy
 nIppkmPH7P4wr5N0tBpTntAsi9qBDnn6KdiLN5VYtKOjOW21dB6epZnO7fKlbbdBEWmNQy6U
 4aSdkdNOHN
X-IronPort-Anti-Spam-Filtered: true
THK-HEADER: Antispam--identified_spam--outgoing_filter
Received: from p222210.vpn-dyn.fh-koeln.de (HELO MAC15F3.vpn.fh-koeln.de) ([139.6.222.210])
  by smtp.intranet.fh-koeln.de with ESMTP/TLS/DHE-RSA-AES128-SHA; 06 Aug 2022 06:01:46 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Charity Donation
To:     You <mackenzie.tuttle@ca.rr.com>
From:   "MacKenzie Scott" <mackenzie.tuttle@ca.rr.com>
Date:   Sat, 06 Aug 2022 05:01:43 +0100
Reply-To: mackenzie-tuttle@californiamail.com
X-Priority: 1 (High)
Sensitivity: Company-Confidential
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  My name is MacKenzie Scott Tuttle; I'm a philanthropist and founder of one of the largest private foundations in the world. I'm on a mission to give it all away as I believe in ‘giving while living.’ I always had the idea that never changed in my mind — that wealth should be used to help each other, which has made me decide to donate to you. Kindly acknowledge this message and I will get back to you with more details.

Visit the web page to know more about me: https://www.nytimes.com/2022/04/10/business/mackenzie-scott-charity.html

Regards,
MacKenzie Scott Tuttle.
