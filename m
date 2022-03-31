Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7039D4EE1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiCaTjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiCaTjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:39:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8E41EDA34
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648755384;
        bh=t+pd5nnN/BLBgcMhZewfIZ7V3cZOxT7El4ZWjnd4n0U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=jRYGbR0owV1jNj1qyjlIPjaWwx8o93GKJV5Euwg8RQwlrcLNMmytydH5yCzXWSkr7
         PBpqA7cMt/oGMVQ2boLgZAfBnYs6pGutpe6SueuvC8dyXc2KKhrdBnqdtmViviEXah
         7heE6OC7wooBFNUImc4maHiD2DwUyckwM/vsPhZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from genesis.localnet ([80.187.80.35]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1oBpNr0XSz-00boXP; Thu, 31
 Mar 2022 21:36:24 +0200
From:   Alois Wohlschlager <alois1@gmx-topmail.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Gladkov <legion@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pid: Allow creation of pidfds to threads
Date:   Thu, 31 Mar 2022 21:02:32 +0200
Message-ID: <3412128.IC5jYiYEAv@genesis>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2296693.3NxCkoLgkh"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:pIqMjOucgodaMzVDBkS7oW22Bg7lNsPkkSahvuKflG6rcVRBV93
 JvF/m1LoS28i05au1HFQ9FTr4r2I8KJn0rSAxNSr7RReIn9zjlMVRLrcUSQkvVNba4kK0SI
 6lRUHJAWvUGkx6OrJvxU/RCJYcu3f2St/3VURpEAqTfeLjFI2ktGqtvQNsSLt3P8HA0k4Tt
 x1Ph3ez8CHwQO6F4ibP5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zexKTJhElVI=:oncBVUu6y3PEOAbwqzNWzH
 ld8OPM8zgxqbKUOGpnxubxR3eeNT61nSNnj8TvVwyixq6LFEeF3P8MefKANs9A6FcvQo6KgBX
 P1vWDcKeXqvVomTuzX3EeKU7NyYdOS+3qtk8Rm5pioL83c2iHGpUA4AcQ9gA06AmtRhEeoRwZ
 tvqAHSW/IndxBvVZZghtlnqJDQEc3mN005BAE0ZiIaJuw/5CJMBkWowly4s+YOQ9HLJIHISM7
 Sz3W5602UhgQDH5x9x+kVfGNFIY+tOy1RapMapdnmOK+1vYl3gIf3izctjr7+KvccQwwiasBB
 Y3fcgDVbwV5D4mRC1zIhNX+w3OgqGQthch/DKQ3XjkUc9ws2BUfSwkdnGXqL9R0MpxpqXW6NA
 C0zBWKTAffwH2RpGEvRWzGWPcYB+/H5ZqDcgp5azWytK8zReoZABtwHv3QqaBZtTNoB9+RylT
 oaz5xGO5dOqpJA0HFx2C988irQzSlByY7GO/HzhmJenhc6OgJLPjvBg3N5o4+Prkhn65nwQtj
 /od6AiF2brSKZh9MUY/JwzKDrY05jef6+3Sryn9PfcPHr23ODLWM0L0LOKn+/SedB1o01Yn9P
 lfI5XDLvP5Y8M/kGQP4WK/1Apd1P8++053ljFvGcP+DXQDNhmQhEuP7VodpZX8nMZK7ALMFZV
 gMXDGvXaEX52v9OS6Vlm4OK4r9VwlCZCB+2TTpcA7ixOyi/9JybhO4fsKFqiqyzvHBE2k3TP/
 RKrzj9W2w6COAsvsM1bQMEoPeCgzux0WVg88ZgCYtlkvVwWnpK7X/3i56rWbsEAEPYoxc1zjc
 SydZvuSy1gz+1oomxUIIMIMAdWJYrTqqkvmjnLebXbaGquLK4ze+OshKZrmrg2Eo+S9ahz2xM
 wOX1fXh2HnKPObDetQ62mvyAz0bE+V+PkIcL3v7R2dv9zmIdhvDeROEuAQemmVKTTzBG/gJW9
 TcOncNJ4AGT2kt+wRqiDp16Q1FvEQmnCKnWKvgXToJhy1joMQx/gWI53KaQIUq6hYNAvtqGlq
 D0qc9VuP4+UPzaZ9W03WzR7iObdwZMHlyB6ZZNsCaDz4QZQzpFPaC/5Hi+5sKphEZACWbyBN+
 +vwWuZxUwWKjok=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2296693.3NxCkoLgkh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Alois Wohlschlager <alois1@gmx-topmail.de>
To: Christian Brauner <brauner@kernel.org>
Subject: [PATCH] pid: Allow creation of pidfds to threads
Date: Thu, 31 Mar 2022 21:02:32 +0200
Message-ID: <3412128.IC5jYiYEAv@genesis>

The pidfd_open() syscall now allows retrieving pidfds to processes which
are not thread group leaders. Like standard pidfds so far, these may be
used to retrieve file descriptors from the target thread using
pidfd_getfd(), as well as for killing the target thread group using
pidfd_send_signal().
However, unlike pidfds referencing thread group leaders, they do not
support polling for process exit. Attempts to do so signal an error
condition instead of blocking indefinitely.

Since the semantics of pidfd_getfd() and pidfd_send_signal() are not
very useful within a thread group, these thread pidfds can only be
created using pidfd_open(), not via clone().

Signed-off-by: Alois Wohlschlager <alois1@gmx-topmail.de>
=2D--
 kernel/fork.c |  3 +++
 kernel/pid.c  | 15 +++------------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f1e89007f228..f98230630a57 100644
=2D-- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1836,6 +1836,9 @@ static __poll_t pidfd_poll(struct file *file, struct
poll_table_struct *pts)
        struct pid *pid =3D file->private_data;
        __poll_t poll_flags =3D 0;

+       if (!pid_has_task(pid, PIDTYPE_TGID))
+               return EPOLLERR;
+
        poll_wait(file, &pid->wait_pidfd, pts);

        /*
diff --git a/kernel/pid.c b/kernel/pid.c
index 2fc0a16ec77b..6be745c7399c 100644
=2D-- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -548,11 +548,6 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned i=
nt
*flags)
  * Return the task associated with @pidfd. The function takes a reference=
 on
  * the returned task. The caller is responsible for releasing that refere=
nce.
  *
- * Currently, the process identified by @pidfd is always a thread-group
leader.
- * This restriction currently exists for all aspects of pidfds including
pidfd
- * creation (CLONE_PIDFD cannot be used with CLONE_THREAD) and pidfd poll=
ing
- * (only supports thread group leaders).
- *
  * Return: On success, the task_struct associated with the pidfd.
  *        On error, a negative errno number will be returned.
  */
@@ -566,7 +561,7 @@ struct task_struct *pidfd_get_task(int pidfd, unsigned=
 int
*flags)
        if (IS_ERR(pid))
                return ERR_CAST(pid);

-       task =3D get_pid_task(pid, PIDTYPE_TGID);
+       task =3D get_pid_task(pid, PIDTYPE_PID);
        put_pid(pid);
        if (!task)
                return ERR_PTR(-ESRCH);
@@ -595,7 +590,7 @@ int pidfd_create(struct pid *pid, unsigned int flags)
 {
        int fd;

-       if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+       if (!pid)
                return -EINVAL;

        if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
@@ -616,11 +611,7 @@ int pidfd_create(struct pid *pid, unsigned int flags)
  * @flags: flags to pass
  *
  * This creates a new pid file descriptor with the O_CLOEXEC flag set for
- * the process identified by @pid. Currently, the process identified by
- * @pid must be a thread-group leader. This restriction currently exists
- * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
- * be used with CLONE_THREAD) and pidfd polling (only supports thread gro=
up
- * leaders).
+ * the process identified by @pid.
  *
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
=2D-
2.35.1

--nextPart2296693.3NxCkoLgkh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEypeoIv8kJdR0rz5L4PWepeUhaRQFAmJF+sgACgkQ4PWepeUh
aRQ7yg//Q2dmkkaR2O8Ze1ZUC62HOismnJntR5jFn1DTAOg8tRsLPyAooPKso6zY
I6TS1TanCd2I2QFAjZXQ3jz6FKI/yR5pfFbRtHySylIigpqAEpK/NqPnAfqHDmCX
XYgS0+iSvHCJZUejANJDLwBleQOjvWmnYKnIbVGRSITYYzg7//IS2BlKWt6k90Ov
dxi5tdACAeQHCN8yJ8KKbtBhJe7A89NkTueD6Gp0q07FtK9mPmWaR5rmdApVdupe
5g3u+kxxBhaLexwrtT+Z2YZsO/0rHsJbCXOmOcQN7VlyL7eZ5Q8rg3nGpDXX1wrw
oAj6y8UmRWufXbPKbd3/yLAO+u5U7DYXKEIV1TcLJpL7sw2Fsv6WAdYQjxxflW5z
hawEfIPQ3nDs3WijSt6tr+7BNUgv4jgtuTx5gm3FO8A2I8RL6pGwVPPJhtUURswU
9QxDJj5opPoUzFisD5qakbm0nXiZlMBcS2PUESkp7KKOeV3gXspsujR4VDZ/H3KJ
tsGsXmQpyNWhO4MHQf8wI/tvdgGxRf3BHRidEC44TB2C9gt73ME1TdGl26MPbxF3
sTJ5d78bqlTt1wrkW4BOolup3d6r4exT33jxu5VMyyVYyzqwD/Oo8H0+bi8C53i4
Flbl95HfFEtN6iaHhG2l2NAi15uPjwQ3hZTKRlFSpzvcbqCPFec=
=F1tC
-----END PGP SIGNATURE-----

--nextPart2296693.3NxCkoLgkh--



