Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2564E4BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 05:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbiCWEcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 00:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCWEbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 00:31:53 -0400
Received: from sonic317-21.consmr.mail.gq1.yahoo.com (sonic317-21.consmr.mail.gq1.yahoo.com [98.137.66.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FB5583AC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 21:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1648009820; bh=UHqqhARhQk2tEpvZzeynqjMPqlFkPWGdDVNZAAMlX4g=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=OvuRdx9xMyNW5WDesfLqHk2C8RZFP5Sr/Kwv4wKMeRbC+SKH3d9yJBEDcUeAvUQ7LmApMOv+jdS0rj60aBEAaA7Fa1XRF4hPn8ojM5kOtbNno0WQ7YKePbr79Wwj6+5MXypc2oX3TUveNlyur4LVgRIDqMq8zF5YG+zYz4ucpDlI4gRKjBGjKFEzlneTj7CglznCXlyBkOU16vVTmnYs7QULEso2GLVaku4BeNTe7bOKtXsQekNglP0tCGgkN6gSegxjUDrZahu7hONZfjCVE0bcY4txQZKFCApXODdzUc3tPKZLqRAOzV7lrfEsij9prddhQUgGzul+QoP5mYeWaQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648009820; bh=aVF9wlHB4/PgnA/Bzbp3gYhU5qkDNPtf1sLYYfseP2I=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=GlepO4YTWSOtbcrbp3brdTQhAXE7+x1e7f4lUiU3iC5rxmwYJ2NBRvoyKlL7C2FhdCwldKvdQejzpWzdYriKSeyDRVfLM6ZBouvzLKs/a5TfHL/VzPHOfcgrNCIbxBEveMvWVvPxkKDcuungovaTiGd2k9lzRyg+zDWf+5TsRrHJTtJpsueDnKHzlsE+Fy6GOy3YMJMuanz6z9kHu/VVXIBWN/sQFc5s8SKlwYpzDuP/bIG4uDKiJzi98jo2VYO6GtksXjnyrRMD/kVE8pqVcLE+56VeuA9rjODvL48p5I9LlzSFxRo9sTyUcLrTVv4KJGgIOMh2eQehUdyleKS9RA==
X-YMail-OSG: 7tSaq.wVM1m1vwz7tyZmDTBhjioQIVJBsROQsHb9nj34r5.Dvh3W4fZvxML_li3
 YtY3MesRdw0XbFUT9QIzyrHCtwK4Mo9ne9BR7u3Ha0rE9IeEV5fCb5xNliSI5j51bZqBowfcu_YQ
 jyNHWTEmdPfH7n1kpH4QIUR_ClgDSeUT.kpGUacPxI9t3CjMCcBPg6nVH1YzWQowjx1C4EOTjGGU
 mUYEQzGXwB4q3yPf84ewQ0l_F0E9rLapeQuxvxNriIVH6R3aPguT4_1wKPVtN4Khmv18k0Q.Pdv2
 _LI.BomBL0TvblwpHrOXa_Vwgd1ew5vtnP0QrMK_dHGuMlEmCXSTzj6FZdR_ux7uimh0ffJeRuFh
 T8oJzoFFp43rhPCr9cnh7RGjO8ss5vMERdWLL_m1zajwexT961_86GvKQbXsXNqJWNs1igZevcWe
 8dNcWG.gp0QFyztrSB2pxCSgIal6L2Fy4MNvAL_HxsKsT0Vl8uHL0gSGIT3LrniG9GkUMxgsS5np
 oQtgk5hKTFTov7y3LPB5_PEzco50IeTA7X.ZYw5mbcx5zmyeYAyQiaVXGNpyK9ccfqqDWkC_QX9r
 qZTGOMTpvw3H4BI9hh12QhmwRlERss7jlT.zDZFLg6NajSreudYmgaL2IUm1SqnbaM8u1iUm6Vp6
 d93yfZBaKhIDCkfW5IyNO3pEfNkiZtDJ3cfNseW3OHuW3Bwe0gmKLl10DmO1VOgyj0FR1vW5Zgow
 0qPn.rJbrnGy1ua3PpRuEqkevDsKg2g8Rk9Htfs00B5Zph3xsYpCKxxi5NkYroa20HynHXwVzU2H
 Zj0JcJi0Uexdp6pGX6uD4BmOx442lvUF9Utz32Y6ZhXPNOOIJyugTWKt9P3IiWVRoVD0omFrHSZj
 phyGpDELdftB5YlHJBRfgeT.bNR_7chKp4J2hf3jlvlH89XtAN0WpFHNc8x9KSA6LLlISwwqA5LM
 hDyo5a2liaf4cCfnHFw4F5jG3wfY0qjhNVqhtt7iQQbVcoUFt8xoLNiNF4_RO0EJgg95LaqBomC3
 wzunagfNAsibDJooZ5wk.f4S.ZleVM2QvjGN7r12SFO9QEUdkbIUYVI3mlD94XCJvM9hSJr6jpSm
 2nOG0LWTevLswMeo56PJw.Jq1aIostJUE7zRx1HS7.ghzsH80ULvhFaXqcw28Z_Le1fbSQ9ML3Gd
 qQhQQ5NkyedUtmQA_gwWpTPkxuvXhdh..TIt81AZiAEaHG1V8I52GugsIyIgqsEvopaF2Xs5Ad3Y
 JftrfSMP6E6qQ7zRf1q0mNXHMV5DGm4TTiYnMcELjnwKV8cpM9pxvhrqfrHcM8JlV7sFLhy9pJfP
 iNPUI8ejNeqcOZvU3SOsc9zkjrV7swl142KL5Y0MrlbgQ6tRqBTgja75O0nwFL27i5PYhPGJCoUf
 V4M_AW2Z6SVjZ9yNUy3Wkk2CzNgrgSOztPic7KLbLxCB6V0wEmEPfPtuZcFwqMgSRRODzIGVShOy
 Fe39SL0oGjoiACO8EgXyunj8wG8BDzH3RlNkbZSsL.G8Rz5yHzEdRHY2IOL4TZ_nZO2tVt7Mii5h
 C7y1Cx.Zijxp_4z0RkiTWzq1o3t6NReiVzKV1K2FYYH.qKQBYMUs2i2p3r70nwaXh8b0GdVdbGnE
 0t65L910zkyV1l8IG7E.XRtcYTdUeeK7QuBoKOe.SJKAX0hb7JP36BGJlaNVBN_vo1UFP0Q9TAlO
 i4Oelim6ZlvBTMPO0hbZAZ3FRMbSUvrx0F05gSzdsGU5N7zJV8nFaXQiLq1iU2JoTLB9ZUSx6gx4
 edYCQVO5MWKduC2zvhbs92NZgq_KBPq2Av71UOuV699YFy4sU5Mt7pcwWEvMw1wr1vEC.dW.de7R
 w8uQzRrMIhtg_CDMHKt9sBOdIjleJG4AjwbI7nd1GSF44T9uqoBUA0Bpgfjc8dHncbTguCM5tUgZ
 mBdeVAkugIUmpvvlUEM5Duc3qOo.Jb30x98ZDnqLvs4rq.DXHAsC.t1tLTBnceGY2x6EhVUyZjII
 lmNAqENHKyai07FCyE6.68LGjeS5hGOSlYs1NOiohnFLdzqvZcm4wagK68ahFwkl6o7W1k5IPLhY
 c1tqGvQzGf6u3mliseyJX_V.HCF5k8XLj68xmB7Mwc499l5wAnkaQHl5jiyqqH7ddfCQ0Vz1meXj
 iyjvKwaFqa3_WKNEIKNhDTSb1TadgmOKHdeTExsyGccfkj.4F7wzKEx2DqVn6zd0IUnG6XgNxST2
 wqHjqopsQNRmoFJqEOMByTwvlhwnf5DRbOZdC2L4Ou0UNqkgElcxMSbIX2VvW4PeydcXnuC6m7ex
 wD_6QUw--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 23 Mar 2022 04:30:20 +0000
Received: by kubenode527.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2352dcf8460b8a385807e15ebea4de06;
          Wed, 23 Mar 2022 04:30:18 +0000 (UTC)
Date:   Wed, 23 Mar 2022 00:30:14 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>
References: <20220322191436.110963-1-Jason@zx2c4.com>
In-Reply-To: <20220322191436.110963-1-Jason@zx2c4.com>
MIME-Version: 1.0
Message-Id: <1648009787.fah6dos6ya.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.19894 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I searched for users of RNDADDTOENTCNT using=20
(?s:ioctl.{1,500}RNDADDTOENTCNT) on Debian Code Search and=20
"/(?s)ioctl.{1,40},\s*RNDADDTOENTCNT/ -path:incfs_test.c" on GitHub Code=20
Search (beta).

Several programs use it for testing purposes, without writing any=20
entropy to /dev/random or /dev/urandom, including rauc, wireguard, and=20
openSUSE kdump. Several programs use it as intended, after writing=20
entropy to /dev/random or /dev/urandom. Of the latter group,

- kata-containers is a lightweight VM implementation. Its guest-side=20
  agent offers a gRPC endpoint which will write the provided data to=20
  /dev/random, then call RNDADDTOENTCNT with the length of the data,=20
  then call RNDRESEEDRNG. As far as I can tell, this endpoint is=20
  made available to users on the host, but is not used by=20
  kata-containers itself.

- aws-nitro-enclaves-sdk-c is an SDK for building lightweight VMs to be=20
  used with AWS Nitro Enclaves. kmstool-enclave is a sample application=20
  provided, which writes "up to 256 bytes" (from where?) to /dev/random,=20
  then calls RNDADDTOENTCNT, then repeats the process until it reaches=20
  1024 bytes.

- sandy-harris/maxwell is a "jitter entropy" daemon, similar to haveged.=20
  It writes 4 bytes of "generated entropy" to /dev/random, then calls=20
  RNDADDTOENTCNT, then repeats.

- guix is, among other things, a "GNU/"Linux distribution. The provided=20
  base services write the seed file to /dev/urandom, then call=20
  RNDADDTOENTCNT, then write 512 bytes from /dev/hwrng to /dev/urandom,=20
  then call RNDADDTOENTCNT, then "immediately" read 512 bytes from=20
  /dev/urandom and write it to the seed file. On shutdown, 512 bytes are=20
  read from /dev/urandom and written to the seed file.

I was unable to locate any other public non-archived usages of=20
RNDADDTOENTCNT on Debian or GitHub Code Search.

I don't have any particular expertise with the random subsystem or=20
conclusions to make from this data, but I hope this helps inform the=20
discussion.

Cheers,
Alex.
