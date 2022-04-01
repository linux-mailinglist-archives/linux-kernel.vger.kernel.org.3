Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416884EEA14
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbiDAJDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiDAJDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:03:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D1125F667
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648803638;
        bh=A3dsJ2AXBiFkTvR2SoKOxX+hgIr1pcvpMiQ8AAPATCo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U0B/7xUgHIBRZCONDSD4540AsBZEgTnO6HPKt/0HU6D+xvF+r2n9YJ/bXrf2KtcZv
         TyIgfAFwguW9g95+99/aYjaCscWtGy2VkGL8g2TugVb6oFo649gtN4McPvAljnPJL9
         pmC2Z/6OGBxFTQBiYD7CwVtABZjIo//KsTFPmCkk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from genesis.localnet ([217.232.146.93]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DJv-1nbZWd0p9J-003ZlA; Fri, 01
 Apr 2022 11:00:38 +0200
From:   Alois Wohlschlager <alwoju@gmx.de>
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
Subject: Re: [PATCH] pid: Allow creation of pidfds to threads
Date:   Fri, 01 Apr 2022 11:00:27 +0200
Message-ID: <5392366.5i5WIIk9Ns@genesis>
In-Reply-To: <20220401070942.odjbuc5wecfayyok@wittgenstein>
References: <3412128.IC5jYiYEAv@genesis> <20220401070942.odjbuc5wecfayyok@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart36927791.vr0k8ECSMx"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:Mcz+IWskG6bHGd5D+uo1Pru/G0reYgYsMnwEkPHVLHar1c/ob9h
 XT6NLZ338r66vUtCJKuudb6DfC3eCiUycko4I5wphhRxpqcrbsLtuOuHFDDNENKQLAs8pGc
 0uqS0KiipX0AwBqC0ZeiEmGuFMwJt2gSCxU4IxxPZj8DJvwaZ4A6c37c3Io99vqLOuMzStp
 EJeA4OJbJxnFohDPFKpaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v653SADyf1U=:x2Hs4EmUJcTc+Zp/58Yauu
 J7uMH2CL5CNggshXjbhZ3LCMauwP2t08dIGCuRgyDKDhx1aqo7tVL8UeDemt+iikhOnSEvluJ
 hoqaem1RLkb70Ta2Y/nsysjSoOR3+BvT12kKV+srCU6c3Susi5lAsJMcQCcylq6fKOdOxvDX7
 1q2RE3NgDu/SyUvA0eTkKbHpB0cO6r09XJmIJqRnMotEUE5AOAeA9s+19uspukgoYa1dBJKkh
 JCD3rvHESORxrzpNiOn7tPxTFknn/rhKnZ+qiatV2S6lszo5lS+5iBsbWcGarAr3TjUWWhpdR
 Ue57IFkHm/AktNnhrj+4Z7D4F9WxUxX7mmmmk6gcrW9DpCmx71qJOY4uSfDO8eGAA+tt6YjW+
 3GOwWwST6F+WZ2UMbHlbLPrVOJGvM30dfIcCd8uAWc2vlVZKIC4JXFdeF1mBYAv6EPxhMoRjW
 c/WBX3Gf8qfCYYMUpkosEm7YpT5Gl/ZsD73oKgEb3LlJ2yXinoz866pJqkJkyGcI4C+PZ/kWR
 L2fGnybw6LJt6hQn9cA2Bg/0iyxWsBSispnvBbwDG0uGUVlowySjU4Xi71kb5uJbRnb4fdQxL
 b/R+96Lj97SYN5dXLqC8Gggd1ctOKY0XeJRNtBlAytcwcsvhuARUAXh5yz+54pCr3tmo5EX1x
 ZPQwOFcyqAV+E1Trd7zN+Nj886uR0wFeXOQ5aU19Fe7/6jvh0bFTiCGkKCwNRDkaKSuwGszrj
 Qm3ymOnW3cqaPomhVweRD4pz2N68wJ0MbsvoSeLh4BetuSWXeLkh5XriqpPo91Op1ah67DHEL
 AtzBekkW2Xud4b83UWfaKy3zEgR+/BroEB4B/YWXsr+zN7APhKqWqgXjERUE4uPKbiET1FbaK
 M5MrQ5XjB2QQSYizis6WNBRwg8xZcONOfiEjnpcY2Fnlq26Qx3hlhRxHd7z4yeZJ8A69JRkFP
 BC0boBzAAkw95epuH0OBTB1LYatOBqasX/Md+QRR1KoTh+u+tREGAKDXNR7SV6ng/poUO5lHL
 GTgHRoEgJOYiw7tmg8yfUnBA1PtZUhZQBRuEMfBvkNIJz53BF8fo+IiewQR53dK3w6K6ZKEL2
 dD1uSsI/VfGmfE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart36927791.vr0k8ECSMx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Alois Wohlschlager <alwoju@gmx.de>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] pid: Allow creation of pidfds to threads
Date: Fri, 01 Apr 2022 11:00:27 +0200
Message-ID: <5392366.5i5WIIk9Ns@genesis>
In-Reply-To: <20220401070942.odjbuc5wecfayyok@wittgenstein>

Hello Christian,

> We originally blocked this because it is not as easy as simply allowing
> pidfds to be created for non-thread-group leaders.
> For a start, pidfd_poll() currently doens't work if pidfd_task() isn't a
> thread-group leader

I did notice the hang there, that's why my patch changes pidfd_poll to ret=
urn
error on tasks which are not thread-group leaders. IIRC, waiting on specif=
ic
threads is not supported by Linux at all, so I don't see a problem with no=
t
supporting it here either.

> and you'll just hang for CLONE_PIDFD | CLONE_THREAD.

No, CLONE_PIDFD | CLONE_THREAD behavior is unchanged, it will still fail w=
ith
EINVAL. I actually confirmed this by double-checking right now.

> So at least that needs to be adapated as well and there's likely a bunch
> of other corner-cases I'm forgetting about.

I'd be happy to hear about other corner-cases so I can fix them.

> Do you have a concrete use-case you want this for?

My use-case is basically making pidfd_getfd actually useful for its intend=
ed
purpose: there is a seccomp_unotify-based supervisor that wants to obtain =
a
file descriptor from its guest. This currently does not work if the action=
 to
be forwarded to the supervisor is performed in a secondary thread, since t=
here
is no way to obtain the required pidfd.

> Christian

Alois

--nextPart36927791.vr0k8ECSMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEypeoIv8kJdR0rz5L4PWepeUhaRQFAmJGvysACgkQ4PWepeUh
aRSBhQ/8CXQauAadNg4smYJongj+K9af3RvKzcgoGNZ7inOUDRBADIyDIMkiP4QH
1LxDeWn36uwVju5R+lIrW1nbO/aKEh+wEkQz8yQun4saQfehfGDydnk+TPXMPmlw
E575TuBN7qncn2sR0eiOB0QecN8sO1pGHZbM6ZBTndFl9UR+3hMSse/vD9zbfiuP
HhdTRY/Um/GHLTl1KTWua4v7GPLUVpDRh1nTSWaP366jwKX0xkeTqZ7hg1xTmEqz
8c36+TAKS3MEOTt68hTFM3H7VfhzdxJuZRwP5++MlWfAk0B46zDMtRJKykQr9uH5
Lx3BHmnDMt6XB+c9d4sgp+IOt/7HmSA/bEqKTIdb1Ea5eiChwPzQjbLo22L8U1hZ
IxYeStwGSG0fgTPSrBlC+vad8FdTfSNHxNXPTMCmiLawhyXFWnSmfpqmhA6ots+I
G4Ei5duX06BaL4Swwv/f4IxZQVfNIR5nhLsyRrgamh2+K7oakUmoxRLXScpGY9o4
Ghh9+vjSnOB/b0lFtrjorFbYb5w8McSEGLigXfSHXnLfTdIA9a8t/2ojQDWfXIl2
VA58qchxSuXhHPx76Strh3GmT1RLwgzA3qDMCpjdEvwHq5pvC6W5SOOiziNSRx19
Igxi1fXGhJCkKE7krdS4/lqqNxucoaJVvtr1I55CbEd8WzjcgE4=
=PTKU
-----END PGP SIGNATURE-----

--nextPart36927791.vr0k8ECSMx--



