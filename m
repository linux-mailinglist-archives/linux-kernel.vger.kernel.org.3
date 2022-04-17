Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DA8504894
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiDQRTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiDQRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:19:14 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94919C32;
        Sun, 17 Apr 2022 10:16:36 -0700 (PDT)
Date:   Sun, 17 Apr 2022 17:16:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1650215794;
        bh=BhCVCOmnuNgFOO1rD9I/6JxS5gxcxLE8KNOg6vTwl40=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=BMQOLhWhzrIQZV1pNJayvcymzrbCjZUZri7OSbIF2XE5KetnMNiaMJofganSsaVVZ
         NgCsPmeO4hxkkwH8eRmKvH4aIaSFFAQCTkO5miPYSZuKXcgtiZVkBduelN1YiVOnIg
         fKREGmgZSCnoCG4A9jCduJE30ENMx8Gr/flihuafcLpiU/+svcQwCYULn1xFjBUzsq
         5we28u4WyhM4omPCC1BUI7ONQpy+pkjSgvHH/44iHpVuphbIzu/TxOQ6PtNwwj8gi5
         LtwfV6R9luWh1XZarMQjZUqT5jCzd0Iyc9oHPG0u21viCN4EeMwwyk0Jm92VI1zxXn
         BSaFgvtgejflQ==
To:     regressions@leemhuis.info, Basavaraj.Natikar@amd.com,
        bnatikar@amd.com
From:   Marco <rodomar705@protonmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, jkosina@suse.cz,
        benjamin.tissoires@redhat.com
Reply-To: Marco <rodomar705@protonmail.com>
Subject: Re: Bug 215744 - input from the accelerometer disappeared, regression on amd_sfh on kernel 5.17
Message-ID: <nqBA6pARHM6h_5hMj32zIxq_lgo2z8mmj7FPM5bXBv5DhWmh4K5Qv3MbKfAAi0tXlRy2IFYtfgyk2i_GPLIH5xsJ1hKBaLstHiNI1IEdUVc=@protonmail.com>
In-Reply-To: <xZsLVmWExSSYgHXHsfOKkB7SbLy-bltitpJznKV1HHsv2-_ZcSFArnir30v-7Eg8zqmGSMmZi3Cr7YHpB8tD_FVnBvf2W-VsmmFGdc7hlWw=@protonmail.com>
References: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info> <0499f8ae-6966-be4b-5af8-e7e568bfcd5f@amd.com> <6fe27103-5e35-5f16-d213-29bd71412f5b@leemhuis.info> <7dfb121f-848c-873e-f3cc-43239c264f21@amd.com> <0a33735c-dd43-4305-ff92-7b9ac2c6a0d9@leemhuis.info> <539ff0c5-a95b-836d-e1c6-39f64ee2a418@leemhuis.info> <056621a6-b6ac-90d9-c409-ba5d9404c868@amd.com> <-IeN6GQXuvFeZGmf-HSltWI3MN3V02oQzXAW0XR74vD62w_Fo_A6lSfJXrDgV2MTrHs9Id2Ce_r9J_zZCKx67DnVAWeFg3-ULIZ2GSm_ITQ=@protonmail.com> <xZsLVmWExSSYgHXHsfOKkB7SbLy-bltitpJznKV1HHsv2-_ZcSFArnir30v-7Eg8zqmGSMmZi3Cr7YHpB8tD_FVnBvf2W-VsmmFGdc7hlWw=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any updates to this issue? The latest kernel 5.17.3 is still problematic fo=
r me.

Inviato con l'email sicura di ProtonMail.
------- Original Message -------
Il luned=C3=AC 4 aprile 2022 19:40, Marco <rodomar705@protonmail.com> ha sc=
ritto:


> I've added the three test cases (dmesg + sudo monitor-sensor on all three=
 tests) on the bug report on bugzilla.kernel.org. One is with the stock ker=
nel from arch, 5.17.1. The other two is using zen patches on top of 5.17. O=
ne is without the three reverts above mentioned. Sensor is missing still. T=
hen my same custom configuration only with the three reverts applied. The s=
ensor is back and working.
>
> If you need anything more, just let me know.
>
> Link to bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D215744
>
> Marco.
>
> Inviato con l'email sicura di ProtonMail.
> ------- Original Message -------
> Il luned=C3=AC 4 aprile 2022 16:26, Marco rodomar705@protonmail.com ha sc=
ritto:
>
>
>
> > I haven't tested this on the tip of the git tree, I can do this probabl=
y wednesday if it is needed.
> >
> > I'll post the output from sensors-detect shortly.
> >
> > Marco.
> >
> > Inviato da ProtonMail mobile
> >
> > -------- Messaggio originale --------
> > On 4 apr 2022, 16:04, Basavaraj Natikar < bnatikar@amd.com> ha scritto:
> >
> > > > On 4/4/2022 7:23 PM, Thorsten Leemhuis wrote:
> > > >
> > > > > On 04.04.22 09:25, Thorsten Leemhuis wrote:
> > > > >
> > > > > > On 04.04.22 09:18, Basavaraj Natikar wrote:
> > > > > >
> > > > > > > On 4/4/2022 12:05 PM, Thorsten Leemhuis wrote:
> > > > > > >
> > > > > > > > On 01.04.22 21:47, Basavaraj Natikar wrote:
> > > > > > > >
> > > > > > > > > Committed patch is disabling the interrupt mode and does =
not cause any
> > > > > > > > > functionality or working issues.
> > > > > > > > > Well, for the reporter it clearly does cause problems, un=
less something
> > > > > > > > > in testing went sideways.
> > > > > > > >
> > > > > > > > > I also cross verified on 3 system and working fine on 5.1=
7 and not able
> > > > > > > > > to reproduce or recreate.
> > > > > > > > > [...]
> > > > > > > > > ------------------------------------------------
> > > > > > > > >
> > > > > > > > > Looks like this is not regression. May be some hardware/f=
irmware bug.
> > > > > > > > > Well, from the point of the kernel development process it=
 afaics is a
> > > > > > > > > regression, unless the testing went sideways. It doesn't =
matter if the
> > > > > > > > > root cause is in fact a hardware/firmware bug, as what ma=
tters in the
> > > > > > > > > scope of the kernel development is: things worked, and no=
w they don't.
> > > > > > > > > For details please check this file and read the quotes fr=
om Linus:
> > > > > > > > > can you help to answer the below questions:
> > > > > > > > > Me? No, I'm just the Linux kernels regression tracker try=
ing to make
> > > > > > > > > sure all regressions are handled appropriately. :-D
> > > > > >
> > > > > > Marco, can you help out here?
> > > > > > Marco replied in private and allowed me to forward his reply:
> > > > >
> > > > > ```
> > > > > I can't since, as mentioned previously, this is the only AMD lapt=
op
> > > > > device that I have.
> > > > > I am sure this is a regression for me, even if the issue is firmw=
are
> > > > > related. I have tested the 5.17 stock arch kernel and the sensor =
is
> > > > > gone. With the last three patches reverted the sensor is back and
> > > > > working fine.
> > > > >
> > > > > I would love to verify if the issue is hardware or software relat=
ed, but
> > > > > being outside of AMD and with AMD not releasing any public inform=
ation
> > > > > with datasheet/specification on their Sensor Fusion Hub I really =
can't
> > > > > say anything specific.
> > > > >
> > > > > This still remains a regression, since the hardware was working b=
efore
> > > > > and now it doesn't.
> > > > >
> > > > > By the way, I already have seen also this rework of this specific=
 driver
> > > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fgithub.com%2Fconqp%2Famd-sfh-hid-dkms&data=3D04|01|Basavaraj.Natikar%40a=
md.com|05891d0582f94d68e7f908da164272ca|3dd8961fe4884e608e11a82d994e183d|0|=
0|637846771908092322|Unknown|TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|3000&sdata=3DnAmJdcP2ALl9cEaejWezLb9B3bU5O=
mp72Z6kjTbaBRY%3D&reserved=3D0 that even added a still
> > > > > missing handler for the lid sensor switch for disabling touchpad =
and
> > > > > keyboard, and all efforts tried to merge it upstream with all sor=
ts of
> > > > > issues.
> > > > >
> > > > > Regardless of everything, this is a driver supported in kernel by=
 AMD
> > > > > engineers, so all of this doesn't matter. On my hardware this thr=
ee
> > > > > patches break a previously working hardware.
> > > > > ```
> > > >
> > > > Thank You Marco for the information.
> > > >
> > > > Could you please provide me below results for acceleration
> > > > by re-applying and reverting patch once again on same laptop.
> > > >
> > > > Did you attempt to test it multiple times on the tip of the git to =
see
> > > > if the problems goes away?
> > > >
> > > > if same test is performed multiple times with or without reverting =
patch
> > > > on same laptop on which issue is observed
> > > > we may see same working/issue behavior. if it is regressing then al=
ways
> > > > it should work with or without reverting patches on same laptop. is=
 this
> > > > the case here?
> > > >
> > > > Thanks,
> > > >
> > > > Basavaraj
> > > >
> > > > > Ciao, Thorsten
> > > > >
> > > > > > Ciao, Thorsten (wearing his 'the Linux kernel's regression trac=
ker' hat)
> > > > > >
> > > > > > P.S.: As the Linux kernel's regression tracker I'm getting a lo=
t of
> > > > > > reports on my table. I can only look briefly into most of them =
and lack
> > > > > > knowledge about most of the areas they concern. I thus unfortun=
ately
> > > > > > will sometimes get things wrong or miss something important. I =
hope
> > > > > > that's not the case here; if you think it is, don't hesitate to=
 tell me
> > > > > > in a public reply, it's in everyone's interest to set the publi=
c record
> > > > > > straight.
> > > > > >
> > > > > > > Did you attempt to test it multiple times on the tip of the g=
it to see
> > > > > > > if the problems goes away?
> > > > > > >
> > > > > > > if same test is performed multiple times with or without reve=
rting patch
> > > > > > > on same platform (laptop/hardware/firmware) on which issue is=
 observed
> > > > > > > we may see same working/issue behavior. if it is regressing t=
hen always
> > > > > > > it should work with or without reverting patches on same lapt=
op. is this
> > > > > > > the case here?
> > > > > > >
> > > > > > > I don't see any regression here. I requested to retest with o=
ther
> > > > > > > hardware/platform/system also as per my above test (output) a=
ll working
> > > > > > > fine in 3 different platforms and not able to reproduce or re=
create for
> > > > > > > my side on 5.17.
> > > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Basavaraj
> > > > > > >
> > > > > > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-n=
ext.git%2Fplain%2FDocumentation%2Fprocess%2Fhandling-regressions.rst&data=
=3D04|01|Basavaraj.Natikar%40amd.com|05891d0582f94d68e7f908da164272ca|3dd89=
61fe4884e608e11a82d994e183d|0|0|637846771908092322|Unknown|TWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|3000&sdata=
=3D9ORA2inmfocvEJ%2FXOov67q2ebzZrcuguViSPV%2B58yA0%3D&reserved=3D0
> > > > > > > >
> > > > > > > > Ciao, Thorsten
> > > > > > > >
> > > > > > > > > Just curious reverting this patch how it is working just =
suspecting
> > > > > > > > > firmware undefined behavior.
> > > > > > > > >
> > > > > > > > > If possible, please check on other platform/system also i=
f same behavior
> > > > > > > > > occurs.
> > > > > > > > >
> > > > > > > > > Could you please provide me platform/system details so th=
at I can check
> > > > > > > > > this behavior?
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Basavaraj
> > > > > > > > >
> > > > > > > > > On 4/1/2022 1:36 PM, Thorsten Leemhuis wrote:
> > > > > > > > >
> > > > > > > > > > Hi, this is your Linux kernel regression tracker.
> > > > > > > > > >
> > > > > > > > > > I noticed a regression report in bugzilla.kernel.org th=
at afaics nobody
> > > > > > > > > > acted upon since it was reported about a week ago, that=
's why I decided
> > > > > > > > > > to forward it to the lists and all people that seemed t=
o be relevant
> > > > > > > > > > here. It looks to me like this is something for Basavar=
aj, as it seems
> > > > > > > > > > to be caused by b300667b33b2 ("HID: amd_sfh: Disable th=
e interrupt for
> > > > > > > > > > all command"). But I'm not totally sure, I only looked =
briefly into the
> > > > > > > > > > details. Or was this discussed somewhere else already? =
Or even fixed?
> > > > > > > > > >
> > > > > > > > > > To quote from https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744=
&data=3D04|01|Basavaraj.Natikar%40amd.com|05891d0582f94d68e7f908da164272ca|=
3dd8961fe4884e608e11a82d994e183d|0|0|637846771908092322|Unknown|TWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|3000&sd=
ata=3DpLGKHCV1ZNrXghGdDFG16sguRA8xi0VzUSG%2Fbw%2FQsBw%3D&reserved=3D0 :
> > > > > > > > > >
> > > > > > > > > > > Marco 2022-03-25 15:22:19 UTC
> > > > > > > > > > >
> > > > > > > > > > > After updating to 5.17, the input from the accelerome=
ter disappeared, completely. No devices available from IIO tree. First bad =
commit causing it is https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%=
2Flinux.git%2Fcommit%2Fdrivers%2Fhid%2Famd-sfh-hid%2Famd_sfh_pcie.c%3Fid%3D=
b300667b33b2b5a2c8e5f8f22826befb3d7f4f2b&data=3D04|01|Basavaraj.Natikar%40a=
md.com|05891d0582f94d68e7f908da164272ca|3dd8961fe4884e608e11a82d994e183d|0|=
0|637846771908092322|Unknown|TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|3000&sdata=3DL36JFc%2BnejM4bJXfNui49v2uJKr=
S4cJnU93dpEhXPms%3D&reserved=3D0. Reverting this and the the other two on t=
op fixed this. Tried to not revert only the above mentioned commit, but it'=
s still not working.
> > > > > > > > > > >
> > > > > > > > > > > Marco.
> > > > > > > > > > > Anyway, to get this tracked:
> > > > > > > > > >
> > > > > > > > > > #regzbot introduced: b300667b33b2b5a2c8e5f8f22826befb3d=
7f4
> > > > > > > > > > #regzbot from: Marco rodomar705@protonmail.com
> > > > > > > > > > #regzbot title: input: hid: input from the acceleromete=
r disappeared due
> > > > > > > > > > to changes to amd_sfh
> > > > > > > > > > #regzbot link: https://nam11.safelinks.protection.outlo=
ok.com/?url=3Dhttps%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D21574=
4&data=3D04|01|Basavaraj.Natikar%40amd.com|05891d0582f94d68e7f908da164272ca=
|3dd8961fe4884e608e11a82d994e183d|0|0|637846771908092322|Unknown|TWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|3000&s=
data=3DpLGKHCV1ZNrXghGdDFG16sguRA8xi0VzUSG%2Fbw%2FQsBw%3D&reserved=3D0
> > > > > > > > > >
> > > > > > > > > > Ciao, Thorsten (wearing his 'the Linux kernel's regress=
ion tracker' hat)
> > > > > > > > > >
> > > > > > > > > > P.S.: As the Linux kernel's regression tracker I'm gett=
ing a lot of
> > > > > > > > > > reports on my table. I can only look briefly into most =
of them and lack
> > > > > > > > > > knowledge about most of the areas they concern. I thus =
unfortunately
> > > > > > > > > > will sometimes get things wrong or miss something impor=
tant. I hope
> > > > > > > > > > that's not the case here; if you think it is, don't hes=
itate to tell me
> > > > > > > > > > in a public reply, it's in everyone's interest to set t=
he public record
> > > > > > > > > > straight.
