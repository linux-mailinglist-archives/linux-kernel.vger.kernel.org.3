Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE51F5790BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbiGSCSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbiGSCSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:18:43 -0400
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37023C8E9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1658196704;
        bh=T4xK7W1C8/EAKpZlNLBDLSvbQJQGFkNtPL6rJnWFjMw=;
        h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To;
        b=X5cnwMG7gsS20huIL/ZBS0AlIG1NvH37KKHp57BZgvKa2V/TbAaWoBUTy5awoXA//
         Zu3DVR8+lr0GSDRJgeKbScojjeoBvI+Kay06EaCQG+nAlAy03MsGiidyAmIjFIh2z1
         xt0eehL6zIcCKe0s28XrhWqIiAjCsF+bzSuUqzbDvpPTLy0FQjYg/r/1EmvUG0eHKI
         G3GF5B1MTOph6rfkKx5XDRGW6CHwEBlWPt3n3G707rO5doOgRGnLkVQ1+gLDbIHg8u
         Myl0ogxbQoJM8ChtFXSCuv1PL+S2EJVe7sgbrXRt5xJlJhfVldOFlVhHZc8Tp2Q8ry
         bfPpel15XldYQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 6C732900474;
        Tue, 19 Jul 2022 02:11:44 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Robin Naccari <robianna1973@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 3/4] seccomp: Support atomic "addfd + send reply"
Message-Id: <197A77C8-41B4-43E9-9779-CA68F39FD92E@icloud.com>
Date:   Mon, 18 Jul 2022 19:11:43 -0700
Cc:     christian.brauner@ubuntu.com, containers@lists.linux.dev,
        gscrivan@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mauricio@kinvolk.io,
        mic@linux.microsoft.com, rodrigo@kinvolk.io, tycho@tycho.pizza
To:     robianna1973@icloud.com
X-Mailer: iPad Mail (19F77)
X-Proofpoint-GUID: 1SsgwYhOc9jBbmZaufleECSYZXZX-DG5
X-Proofpoint-ORIG-GUID: 1SsgwYhOc9jBbmZaufleECSYZXZX-DG5
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1011 mlxscore=0
 adultscore=0 mlxlogscore=519 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2207190006
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=EF=BB=BF


Sent from my iPad=
