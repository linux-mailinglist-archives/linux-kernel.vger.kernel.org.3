Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C9E58962A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiHDCf1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Aug 2022 22:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiHDCfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:35:11 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Aug 2022 19:35:03 PDT
Received: from lvs-smtpgate3.nz.fh-koeln.de (lvs-smtpgate3.nz.FH-Koeln.DE [139.6.1.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0A26052F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 19:35:02 -0700 (PDT)
Message-Id: <c8230b$21d9j5@smtp.intranet.fh-koeln.de>
X-IPAS-Result: =?us-ascii?q?A2D//wCcLuti/wQiBotaHQEBPAEFBQECAQkBFYFRARoIA?=
 =?us-ascii?q?YEWAgFPAQEBgRSBLAEBK4ROg0+IT4NDAYEpgnWLFYFjBQKPBAsBAQEBAQEBA?=
 =?us-ascii?q?QEJEgIlCQQBAYUDAVMBAQEBB4QdJjgTAQIEAQEBAQMCAwEBAQEBAQMBAQgBA?=
 =?us-ascii?q?QEBBgSBHIUvOQ1fAQEBgQw0AQEBhBABAQEGAQEBK2sgAhkNAkkWRwEBAQGCR?=
 =?us-ascii?q?kUBAQGCHQEBMxOiK4dhgTGBAYIpgSYBgQuCKQWCcoEXKgIBAQGHZ5BcgQ8BA?=
 =?us-ascii?q?oUYHROCUgSXbwICGjgDNBEeNwsDXQgJFxIgAgQRGgsGAxY/CQIEDgNACA0DE?=
 =?us-ascii?q?QQDDxgJEggQBAYDMQwlCwMUDAEGAwYFAwEDGwMUAwUkBwMcDyMNDQQfHQMDB?=
 =?us-ascii?q?SUDAgIbBwICAwIGFQYCAk45CAQIBCsjDwUCBy8FBC8CHgQFBhEIAhYCBgQEB?=
 =?us-ascii?q?AQWAhAIAggnFwcTMxkBBVkQCSEcCR8QBQYTAyBtBUUPKDM1PCsfGwpgJwsqJ?=
 =?us-ascii?q?wQVAwQEAwIGEwMDIgIQLjEDFQYpExItCSp1CQIDIm0DAwQoLgMJPgcJJixMP?=
 =?us-ascii?q?g+WQ4INgTgCMIcLjUKDZQWKVKBbCoNRgUQCk32MKIJGknQOBJF9CYVvhHaME?=
 =?us-ascii?q?KdXgXiBfnCBbgolgRtRGQ+SEopfdAI5AgYBCgEBAwmMZIEKgRgBAQ?=
IronPort-Data: A9a23:lq+fN6AUlJvFxRVW/7rkw5YqxClBgxIJ4kV8jS/XYbTApDkk1GFVm
 GVNXWyHbKmDajfyKdp+PIW090sG68SEyIQwOVdlrnsFo1CmCCbm6XZ1Cm+qYkt+++WaFBoPA
 /02M4WGdoZsJpPljk/FGqD7qnVh3r2/SLP5CerVUgh8XgYMpB0J0HqPpsZg6mJWqYnha++yk
 Y6qyyHvEAfN8yJ5NGsS95WCpHtH1BglkGpF1rCWTakjUG72zxH5PrpGTU2CByeQrr1vIwKPb
 72rIIdVXo/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYozqCsulL4
 cxrjsCLTSgRDquWicU4YSANRkmSPYUekFPGCV2WmpXO4RaAbWPqhftuSUIxMIkevOp6aY1M3
 aVDeXZTKEvfwb7eLLGTE4GAguwmJcLoMYUNu3wl0SzFEfIraZvKBb/Qo9Rf2V/cg+gQTauPP
 JBEMVKDajznWQVgPA5PDqhumeCBnyPcKyYJrmKK8P9fD2/7llUqieO9YbI5YOeiWd9cmF2Tv
 GPe423/BBgHMt2B4TWA+3OowOTImEvTRJgbEqaz7P9ynFCV33ESEgw+Wl6yoP3/gUm7M/pAJ
 kYR8zEyoLIa71a2CNTxQnWQq3eHuhcMVsB4HOgz6QXLwa3Riy6QHWsFUhZQb8YlqYk9TFQC3
 V6VnsHkAzdovrOYRFqS876VqXW5Pi19BXMHYjUeTBAe7sX/rak9hAnDR8pqVqWyi7XdAzb6z
 iqW6jMjnagRh84C0Y2851nMhz/qrZ/MJiY/6B/WUmu0xg5iecioa5HAwUDS/O5JKJyUUkSbu
 mMsh8Wa8fsPC42AjiqEXOQKGritof2CNVX0nAY3RJQ5/iW18nq5cJxN+jdlDFtkNtsfeDn1b
 VXVsB9Q45laOD2haqofS4u9Fckw0an7FNLqXffRadpJfbB+cQaG+GdlYkv492vomVMhlKwlN
 pqdeteEAnMTCKAhxz2zL88W1LYw7is7zHiVQor0pzy73LG2b3ucUvECKlTmRvsh64uPpQzOt
 dFFOKOizhxeVKjlfzHP9pQPBVsPJGN9Aor5w+RMa/abJRB6MGokAuSXxqkuE6R+grxNkf3U1
 nK6UV1Vzlfjw33aQS2BbXVqcq/0dZ9i6383IEQR0U2AwyB4Pd73sOEBb51yc+F7suJjiP1zQ
 v0DPcmNahhSdtjZ0zsWQKDHhZVET0iQgS22Dyz/cRkaTac1EmQl5eTYkhvTGDgmV3Tq5Jdm/
 uT9j2s3UrJeH1Q4XZi+hOaHkQLh5CN1dPdaBhOgHzVFRKn72KRHQ8AbpsA6ONoBLRTFyVN2P
 C7LWUxI9IEhT6cT98PVhei+r4avHq5BE1FGB2nS6be/XRQ2H1ZPIqcZDo5khRiHCAvJFFyKP
 I24D5jUaZXrZmpivYtmCKpMxqkj/dbprLIy5l06QSSWMg33Ue4xfCLuMSxzWktlmeIxVeyeB
 RnnxzWmEe/VZqsJ7XZOdVp1P7XZvR3qsmWDtKxsSKkF2MOH1ODeChwJb0jkZN11ILZoLJguw
 eo68MAR8Re0igcsPc2AgzxGn1lg3VRfO5jKd/gyXufWt+bc4gofPMOFVnKnsMnnhhclGhBCH
 wJ4TZHq39x0rncuuVJqfZQR9YKxXagzhS0=
IronPort-HdrOrdr: A9a23:Bt8KMaMEyq21fcBcTtajsMiBIKoaSvp037Hjv3ocdfUzSKGlfq
 GV98jzuiWVtN98YhAdcLO7UpVoKEm0naKdh7NhXotLmWLdyQ6VxepZgrcKrQePJ8SEzJ8+6Z
 td
X-IronPort-Anti-Spam-Filtered: true
THK-HEADER: Antispam--identified_spam--outgoing_filter
Received: from p034004.vpn-f04.fh-koeln.de (HELO MAC15F3.vpn.fh-koeln.de) ([139.6.34.4])
  by smtp.intranet.fh-koeln.de with ESMTP/TLS/DHE-RSA-AES128-SHA; 04 Aug 2022 04:33:57 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Charity Donation
To:     You <mackenzie-tuttle@ca.rr.com>
From:   "MacKenzie Scott" <mackenzie-tuttle@ca.rr.com>
Date:   Thu, 04 Aug 2022 03:33:54 +0100
Reply-To: mackenzie-tuttle@californiamail.com
X-Priority: 1 (High)
Sensitivity: Company-Confidential
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
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
