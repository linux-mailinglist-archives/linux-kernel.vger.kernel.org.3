Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FB555E620
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347703AbiF1PC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347681AbiF1PCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:02:51 -0400
Received: from sonic306-20.consmr.mail.gq1.yahoo.com (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91B533E3C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1656428570; bh=mJdxWi+vRg5mX2ammRonQra2G8KMb7ygMvIk+e3y9ss=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=oL0go7DAuaFwQBzxvAj93d5o/SRTjNurU3QevVXsSEJxvo7Naj/0J+rNSfMdOvVLsbXQIJTgLgUCMJlU0HpKFx6gGK9IgnHONv6IJij+vdQjV6ecfmmbLwOdIjumy+0fQbsK0oG9uoW+5C7HxIjlr3BK4byXi+oNWczQp9HFN883jCjR0EzSS1D23qiEoH3byuhhARCoFcBPywWTnQBv0gzW2LVDgM0OIVqLSNFpWDvjoqS2lFSIurwF/S+22aH7CpNFfNS1vHakRqRd2/HI9C46cobOKtf9FPhbbw1Zm5jyeYnxIE2nSmowLa/xjdkZfrTXQXfg2yLIXIjWtynpSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656428570; bh=jCd3itgRrfW+cbzZVwm+EqZW7GYNioHLqwThqMhCf88=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=Kyb1zFacnb78pUvFy50wTca1sb81DaB6HtI8PgG8iONE6NYQmjP7wHrP2HzY373G+jENj7C3h5RZPwJkPsYcWWd6Db/PDZMWGY8RBEROJazlTHT4SWWIBTlA0aYNrASoT0OP8xOJ6S8DMftdpzq99pT1kMAs65hL9rSRlKiuThVN84a1Kj8A2FybZZSrlgcLDY3bmHae3cAq6w9Vtn8wzSbyt97KbwuS+xfwj2zh8nK8Xm3Dzie84jYbgbk7hI9sK0eFajuwy4SxSIbPm3bGypsRflNTQY4pOoL5XXb/b6S0CS6Zxm5IeQKON/mBxBnenpvE0tMmSjFFxY6E31Dq6g==
X-YMail-OSG: 8l3EnbgVM1l8CCCIXzJxNxhAKM2TpC2vXdUg0UqinPjPg6O0qI8zEPIiarA5C.6
 sqK__HFKUxJT7zG1JF6uGyon9oNZeN.0NMaSIEV7ygGfCt_44w.Rf7IZ7LX75WljTynAu8y4FB0U
 6YyvqeNwvdkcw7Zi1A2VaGy8Pr6wmnSRGOPVqbeB.4WAe6qENHe5ovv5fDgSbJskfbR48ooPEbZa
 GT9kqL8KPN9iddqNFX0KYDckpu_St4Dg_bJMomamg3v0y_pRC1lLcOZepb1EY40LBeyEVcUmkaYc
 htrO0M3Y1XVJSq_zXJJPJ7gB678jrfTtCxlt4ljAxg5AN6MZTq3TjmxeIZH_mvLhUlB._a4Gl7jg
 0rjIkvsvIObtyCOs8rfZGOVNBktELh7d8LKPC06OGfW5lwoRfTsmlTrLWmyXbsxkm6LjXXph1zMv
 4cTXHoOgT1elisfOUAn89_C_X4CU5ffzj5IB30.619RChRzIGS.c91OYydQpBLs2sdejBOczNqk9
 9RRYOGf2Ph4uDIh.MHgigFya1.bpZmSQRnL1JK6UBye7sP72dHwohaVg3.7N9iEZZ47WDTki63Qb
 yjkf5uix3Y2CCu.Yge1ZD6zJ9UiGQm4T1NGZA3bNjErwXJeC_zFyb4NbG0bY8ifpVmC7yHOwg7DG
 BguLJMBTCIa4pyczbP_.8UYiHtVVrBl3GDljrXeyZqc1abWNA9Ygi5O3wilDFT98KrWP_U_gaLgo
 ZSIhVdLd3AVuuvKDi4rMHnUFXMWL87dxe6E46eXTDqkQgOm0SVvAp9bOM0qPMxSLF39sboKrWT1T
 DAyPGxGByBXHjFaK6Jo7Po7sTRCKEuNyTiEK9Z9Qj3sme9oVUFKu7Fd87TOqHVMwOyvfnBsZYvUU
 up5uKXk82aAGeMXt5ajhXOz9C9ek9B.o2Hpw2UI8PIWZ4dHS8j5xuvfuUefecUQXHRQE6Inywd.q
 n56c5F.6OipJO56OGat.CE0_OriiFEIMMRIYA_6V1WB7W1LC3sd8Fwf.EOHrzGUFxawP7UdAwrB6
 7ssTU68z7BjT7ZGWkQkIunN3CrTJj1NWO5fZKUcE602y5.d4Lj1b4gle4_o89wjnjPAAgY0Ka71z
 WApZ1JtlmXfbbIiWdUiCh9iX.TmRttEFov8jR5tUjFh8W4nnmLPa807eo9IuSTNEyq.TxBm4UyGX
 F_fT2GpgbfnRQp2L7QbI74g2oJcklkXbHSdO.NrycSWXa_C4PJJ009EB5wsajzo6VbnM0Eqxj3ie
 w3y0sBZAv6Arrr9F3XMr5FgW0qz7fQD8swtray_N86ZnmH1voqWp6wdQKFDBE0Ip7ptzjm4XABDE
 WBDpX90oIdlog6Rp0iSOlLgCdy690WT4waROdjllIOthw.KDy8sqpvdWe3C_OV_OdchxsN4MvlL2
 q9LGvPwBIx2MOY7.ugLKHb40kD60M8O_ZAxskSqmNl_VlrOm8PkYJtkRzOwcMi.jtWWKdmxUzr0C
 c8OOrCFk7BccDWXSsnGkFq_fsvW8V4vmkcVm8cksdgIcSY.79e.dby7lCnGaph.hsW2OgNUG0zNL
 eTmcXgMIr9PQAALPd7h6tEenUYcXm54oST.zqMo.epoa.TRMnz0X3JbEQF.iNpZ.nuAHEH76cNz8
 pMXH4P2wmkKpTEyfnK7.E.4XimdBJKhoaXmn65v475DcZN6YclHEyNxDpIV98aWJKZlAWGKpiiUt
 GSH9_xjTBg3yUgKAIfFBjo_nh_0wAsz.3zqzsB3VltPtlRVf4HoaUU3IRSH1mW5hI2S80YRd364B
 pzCnFbwJ1ipO4b_.gWo3ZUTFG8ZquVjbwg_EZhD3ntSUnZPz8EhdkBATSwv7u_Z.JvijpFFrkb_K
 P1mjNUZJlWW24M6xUwH1ujYMjMT1Us7WIVnoHpNc4UkvrkgBPiiqhjOEslIxwO4qIF011kCmq7cE
 n6GcMz4pk89_K_E4agOMiHeDqOMIqczXBLJ1ToDRSTzO.PsyIP_.KM.9QoS2yMpPGUrffuffuDPT
 SEA4drcmjW5CdPtDYMj397rnzeZYDZYf4I7jjIZc1hzpfE9bH4oBn1E1iimW2iSC0RGu9zfKAgj9
 ckpl3gG0d9ywRx6HOg4zext5PJy00TW4GFhYpZ_HtSST9y5jZr4noxyXs4ri6TLx4xW3cjPSXVMc
 45WAcQFycvAXDa0lDCmLxS2Hru6cT2w8nQE9jjZJ0g8DnhJfKCo..ORmue8lKBk7t6_iLwfOP.02
 tSC8x7PbjGtYZGorfeXQT4YvWYonzHcgAT3BMHwcc9CCzpVoiuj6k
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Tue, 28 Jun 2022 15:02:50 +0000
Received: by hermes--production-ne1-7459d5c5c9-f2z7w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f5e4bf9d72858dcfc86edb9d0d0ee251;
          Tue, 28 Jun 2022 15:02:44 +0000 (UTC)
Date:   Tue, 28 Jun 2022 11:02:40 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in amdgpu
 after suspend)
To:     paulmck@kernel.org, rcu@vger.kernel.org, urezki@gmail.com,
        uladzislau.rezki@sony.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?b?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
        Theodore Ts'o <tytso@mit.edu>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org
References: <1656357116.rhe0mufk6a.none.ref@localhost>
        <1656357116.rhe0mufk6a.none@localhost>
        <20220627204139.GL1790663@paulmck-ThinkPad-P17-Gen-1>
        <1656379893.q9yb069erk.none@localhost>
        <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Message-Id: <1656421946.ic03168yc3.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Paul E. McKenney's message of June 28, 2022 12:12 am:
> On Mon, Jun 27, 2022 at 09:50:53PM -0400, Alex Xu (Hello71) wrote:
>> Ah, I see. I have selected the default value for=20
>> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT, but that is 20 if ANDROID. I am not=20
>> using Android; I'm not sure there exist Android devices with AMD GPUs.=20
>> However, I have set CONFIG_ANDROID=3Dy in order to use=20
>> ANDROID_BINDER_IPC=3Dm for emulation.
>>=20
>> In general, I think CONFIG_ANDROID is not a reliable method for=20
>> detecting if the kernel is for an Android device; for example, Fedora=20
>> sets CONFIG_ANDROID, but (AFAIK) its kernel is not intended for use with=
=20
>> Android userspace.
>>=20
>> On the other hand, it's not clear to me why the value 20 should be for=20
>> Android only anyways. If, as you say in=20
>> https://lore.kernel.org/lkml/20220216195508.GM4285@paulmck-ThinkPad-P17-=
Gen-1/,
>> it is related to the size of the system, perhaps some other heuristic=20
>> would be more appropriate.
>=20
> It is related to the fact that quite a few Android guys want these
> 20-millisecond short-timeout expedited RCU CPU stall warnings, but no one
> else does.  Not yet anyway.
>=20
> And let's face it, the intent and purpose of CONFIG_ANDROID=3Dy is extrem=
ely
> straightforward and unmistakeable.  So perhaps people not running Android
> devices but wanting a little bit of the Android functionality should do
> something other than setting CONFIG_ANDROID=3Dy in their .config files.  =
Me,
> I am surprised that it took this long for something like this to bite you=
.
>=20
> But just out of curiosity, what would you suggest instead?

Both Debian and Fedora set CONFIG_ANDROID, specifically for binder. If=20
major distro vendors are consistently making this "mistake", then=20
perhaps the problem is elsewhere.

In my own opinion, assuming that binderfs means Android vendor is not a=20
good assumption. The ANDROID help says:

> Enable support for various drivers needed on the Android platform

It doesn't say "Enable only if building an Android device", or "Enable=20
only if you are Google". Isn't the traditional Linux philosophy a=20
collection of pieces to be assembled, without gratuitous hidden=20
dependencies? For example, [0] removes the unnecessary Android=20
dependency, it doesn't block the whole thing with "depends on ANDROID".

It seems to me that the proper way to set some configuration for Android=20
kernels is or should be to ask the Android kernel config maintainers,=20
not to set it based on an upstream kernel option. There is, after all,=20
no CONFIG_FEDORA or CONFIG_UBUNTU or CONFIG_HANNAH_MONTANA.

WireGuard and random also use CONFIG_ANDROID in a similar "proxy" way as=20
rcu, there to see if suspends are "frequent". This seems dubious for the=20
same reasons.

I wonder if it might be time to retire CONFIG_ANDROID: the only=20
remaining driver covered is binder, which originates from Android but=20
is no longer used exclusively on Android systems. Like ufs-qcom, binder=20
is no longer used exclusively on Android devices; it is also used for=20
Android device emulators, which might be used on Android-like mobile=20
devices, or might not.

My understanding is that both Android and upstream kernel developers=20
intend to add no more Android-specific drivers, so binder should be the=20
only one covered for the foreseeable future.

> For that matter, why the private reply?

Mail client issues, not intentional. Lists re-added, plus Android,=20
WireGuard, and random.

Thanks,
Alex.

[0] https://lore.kernel.org/all/20220321151853.24138-1-krzk@kernel.org/
