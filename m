Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EF2510B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355535AbiDZVfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355487AbiDZVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:35:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDDB27172;
        Tue, 26 Apr 2022 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651008716;
        bh=SqZDgtgezvzFEL487/eq0gdT0cwuVCtc16KxET5zGS8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lKivTNCGDX4uqwtcndsWWaaBp6ES+Nl9n4sQkA1WBGpcCL9HcdvaxTFV98QdB5Nxn
         rVeNMgEbhK4GA3kvxgp+GCLzgRHFhdFdMzE0w0/Vfc67NPWDoUHF4iZyCy8ZrWzt8Y
         +9qLpxnW3ZEJWZAgPzYChuyPVeX7sxVq2aPQ9jAg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mnpru-1oCk4c2rCE-00pMzb; Tue, 26 Apr 2022 23:31:56 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] hwmon: (dell-smm) Improve init code
Date:   Tue, 26 Apr 2022 23:31:51 +0200
Message-Id: <20220426213154.724708-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6LhnrInocM56gWfq4g/9pCxosVgqsn8mTy93STUfjkBML8A6epB
 uawS+gFBMbwX/2+vxyg1oN0W/AXEedDZ82O/FTGw3AiiBo9uLGLuMYVtCgFchWkmjQbTTLJ
 II7dZdzvCfiCIfIYiqwrQkJ7W6RxojfGPlubTDQakc4zGw4yL+7C9hZIB+YszjJDMNjIOq/
 vH9a1J0xnoa6GABzx/tmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XWAMloZH9MA=:ciuGWZqdIZ9pLoMs1LeGn/
 ks7j7676vrvQ4qFRyJJ6YX8BB3Uwlh1x4R0MXM2GdDHY+3Tw+rykR6IzjI1iXI/BE68boqzzU
 DUgANqpdn+SWp3ahRsflcAupK+L6iAOm4L1l62M2BUxYvX08H56y79vL+Z/yEzShXyP+O2Iv4
 moPRELMowgHPoBwD8S6RsrlKtt2AaWQFiy+/LVo+treYatUnFYWgeUI8P2GKOpLmtk7zhjEnr
 dPg4OJ52RjG46jVBYDr6PDXHDLmSxcK+yaeYGTN5XDwAF7z3XepHdvla+vH1n2pVHrt8eVaQ2
 9l5b/50YJNbwBMuCFP7D/rRzdFquKHUUevjj5pOjJazKjFLtG3/Sq6t1eqXrS9bKySOj8fUQP
 b2+cfm3aJ+oY711Xas3bWVU6y6DwzhgY2DfGHBQxXaFAAInXNZSFfFWUH+TJPxT1BbEMi7KHx
 omY8s+khXayazi/tkZ9xV28dX6xtj932BJyU+v4yk5KPnOLQ/KMJWoj43fsMkC0bpVfr2XpcJ
 7O4SMwUkGceh77lJBp2O8uOcXpmYX7Df0zgFjDBGohqfy2l1r1XEO0uUnfDEp2EYVRYFNpwUR
 5MNhMjuPD0+YVW3BgEsJz6DwWAIr6Eg4/1FR4cEoY4FcgyTP2A423jHf8W80l4NJuhjB6joRH
 6ZTEXwBqSY2eusYHj8hv9JiCX7IlS3DlCIlM6XG0sqVscACd2CPP6nxc15ZOa6WfUqF7J4eya
 0JbbO20FO0srzZo/eH2DXCqpQ60dznTUO+GrMWiGSk5Ko2Zw//6qqOqN81zG+v8xB3gHOl4jG
 gbhVtG7s6bFXRxGsG2bxckTZ457jVZVcFTPXECWa17etao25GeUPoe5UhJlQpr7j6x1o0TI52
 xj5Hvia8dbhQSEPpJBNQP2FOFKihGk8h3DiOGNDAzbsAcdiOSVxf5VKk8ArjFu33N5DLfHWJx
 jSg6dxecoZ1JmApuZsz/V2h0nnSXibbbfZAyRuVKaSg5lLjYXMThRi86bKeDtGOKQ03AgrNsE
 VaoRHGzge9DODxJmPP9xEoEeUYY0ylV0bh4XYhQWrBDFOzNZj2FeNfnadro/fYQYgSYywIuib
 c/Rb9jC4DVP4TM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves the init code of the dell_smm_hwmon
driver. The first patch speeds up device initialisation by avoiding
unnecessary SMM calls during init, which might be slow on some
machines. The second patch is a small cleanup patch, while the
third patch allows for easier diagnosis of audio problems caused
by really slow SMM calls.

Tested on a Dell Inspiron 3505.

Changes in v2:
- replace pr_warn() with pr_warn_once()

Armin Wolf (3):
  hwmon: (dell-smm) Avoid unnecessary SMM calls during init
  hwmon: (dell-smm) Cleanup init code
  hwmon: (dell-smm) Warn if SMM call took a very long time to execute

 drivers/hwmon/dell-smm-hwmon.c | 50 +++++++++++++++-------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

=2D-
2.30.2

