Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328B1534D93
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346104AbiEZKtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242925AbiEZKtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:49:33 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4BBCEB89;
        Thu, 26 May 2022 03:49:31 -0700 (PDT)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 24QAnCk2027021;
        Thu, 26 May 2022 19:49:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 24QAnCk2027021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653562152;
        bh=7GCJo6V20e403uG9LgMoxWpt4sneMUh4irGbz+bZduM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=znLsEVbJDtf9zQZyWdQMTWyAhsvbAZOkPyEcjyEaMIirmRO3btT+dbZDacS1opEe3
         dLoz4bQUbdJ8ygZK7IGX7dTT28/QTdn4GyQVnAAmvq5GZGMXgdba5XaniJKNV0w39l
         ZxqKjJLVYLnkQlbFNFlQ1cK5x1nUyxdRZVSxPLRMPltallGeFDZnjN/iZNaAdhw+tN
         dipHx0mCqtFcCOBdkEMf5sCcTLw3S2EEKZ0N+dHDiN2DPWJGeuu/x5LSFU33lL+ndB
         ilBeE5eONBmdaPycUZoDz34nArL+M/yYU9fXC2CsOAJD6IOTWmrkXQ0IL3bPzN7VeQ
         oKgWPq5r/Gtug==
X-Nifty-SrcIP: [209.85.210.179]
Received: by mail-pf1-f179.google.com with SMTP id c14so1404628pfn.2;
        Thu, 26 May 2022 03:49:12 -0700 (PDT)
X-Gm-Message-State: AOAM533ExZppQ6HEtyCRpV6tPP2858ci80pz5MrR8qPnCfpvzDHPBgyW
        A3W79gsTeP+OJk39uXOvu4S6QLQXsY7BoPYSzxg=
X-Google-Smtp-Source: ABdhPJytWsqi1G+hmryVs21gChH2/swJVdtbGsLKi5B4mH/FnwoBXaG70p6bCa0/4EzLIttY4G+AscSoNbCnum2E+mw=
X-Received: by 2002:a63:fc5e:0:b0:3db:5804:f3b with SMTP id
 r30-20020a63fc5e000000b003db58040f3bmr32764129pgk.126.1653562151529; Thu, 26
 May 2022 03:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220523164626.858340-1-masahiroy@kernel.org> <20220523164626.858340-2-masahiroy@kernel.org>
 <CAKwvOd=fZ=V52fOc47O1=0wy36b8q_LO54J0099_GkouzH0SZA@mail.gmail.com>
In-Reply-To: <CAKwvOd=fZ=V52fOc47O1=0wy36b8q_LO54J0099_GkouzH0SZA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 26 May 2022 19:47:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWK0GjKab72MoB3E7jTm83gV1c3Xm6rfzUijrOx0WHjA@mail.gmail.com>
Message-ID: <CAK7LNAQWK0GjKab72MoB3E7jTm83gV1c3Xm6rfzUijrOx0WHjA@mail.gmail.com>
Subject: Re: [PATCH 2/5] modpost: remove the unused argument of check_sec_ref()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 5:44 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, May 23, 2022 at 9:48 AM Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> >
> > check_sec_ref() does not use the first parameter 'mod'.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Perhaps we could enable some -W flags for scripts/mod/?
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---


Thanks for your advice.

-Wunused-parameter found more.

At least, we can clean up find_extable_entry_size().




  HOSTCC  scripts/mod/mk_elfconfig
scripts/mod/mk_elfconfig.c: In function =E2=80=98main=E2=80=99:
scripts/mod/mk_elfconfig.c:8:10: warning: unused parameter =E2=80=98argc=E2=
=80=99
[-Wunused-parameter]
    8 | main(int argc, char **argv)
      |      ~~~~^~~~
scripts/mod/mk_elfconfig.c:8:23: warning: unused parameter =E2=80=98argv=E2=
=80=99
[-Wunused-parameter]
    8 | main(int argc, char **argv)
      |                ~~~~~~~^~~~
  CC      scripts/mod/empty.o
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
scripts/mod/modpost.c: In function =E2=80=98find_extable_entry_size=E2=80=
=99:
scripts/mod/modpost.c:1538:55: warning: unused parameter =E2=80=98sec=E2=80=
=99
[-Wunused-parameter]
 1538 | static void find_extable_entry_size(const char* const sec,
const Elf_Rela* r)
      |                                     ~~~~~~~~~~~~~~~~~~^~~
scripts/mod/modpost.c: In function =E2=80=98check_sec_ref=E2=80=99:
scripts/mod/modpost.c:1885:42: warning: unused parameter =E2=80=98mod=E2=80=
=99
[-Wunused-parameter]
 1885 | static void check_sec_ref(struct module *mod, const char *modname,
      |                           ~~~~~~~~~~~~~~~^~~
  CC      scripts/mod/devicetable-offsets.s
  HOSTCC  scripts/mod/file2alias.o
scripts/mod/file2alias.c: In function =E2=80=98do_hid_entry=E2=80=99:
scripts/mod/file2alias.c:399:37: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  399 | static int do_hid_entry(const char *filename,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_ieee1394_entry=E2=80=99:
scripts/mod/file2alias.c:417:42: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  417 | static int do_ieee1394_entry(const char *filename,
      |                              ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_ccw_entry=E2=80=99:
scripts/mod/file2alias.c:497:37: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  497 | static int do_ccw_entry(const char *filename,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_ap_entry=E2=80=99:
scripts/mod/file2alias.c:520:36: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  520 | static int do_ap_entry(const char *filename,
      |                        ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_css_entry=E2=80=99:
scripts/mod/file2alias.c:530:37: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  530 | static int do_css_entry(const char *filename,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_serio_entry=E2=80=99:
scripts/mod/file2alias.c:540:39: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  540 | static int do_serio_entry(const char *filename,
      |                           ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_acpi_entry=E2=80=99:
scripts/mod/file2alias.c:565:38: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  565 | static int do_acpi_entry(const char *filename,
      |                          ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_pcmcia_entry=E2=80=99:
scripts/mod/file2alias.c:682:40: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  682 | static int do_pcmcia_entry(const char *filename,
      |                            ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_vio_entry=E2=80=99:
scripts/mod/file2alias.c:718:37: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  718 | static int do_vio_entry(const char *filename, void *symval,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_input_entry=E2=80=99:
scripts/mod/file2alias.c:752:39: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  752 | static int do_input_entry(const char *filename, void *symval,
      |                           ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_eisa_entry=E2=80=99:
scripts/mod/file2alias.c:809:38: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  809 | static int do_eisa_entry(const char *filename, void *symval,
      |                          ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_parisc_entry=E2=80=99:
scripts/mod/file2alias.c:821:40: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  821 | static int do_parisc_entry(const char *filename, void *symval,
      |                            ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_sdio_entry=E2=80=99:
scripts/mod/file2alias.c:840:38: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  840 | static int do_sdio_entry(const char *filename,
      |                          ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_ssb_entry=E2=80=99:
scripts/mod/file2alias.c:856:37: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  856 | static int do_ssb_entry(const char *filename,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_bcma_entry=E2=80=99:
scripts/mod/file2alias.c:872:38: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  872 | static int do_bcma_entry(const char *filename,
      |                          ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_virtio_entry=E2=80=99:
scripts/mod/file2alias.c:890:40: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  890 | static int do_virtio_entry(const char *filename, void *symval,
      |                            ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_vmbus_entry=E2=80=99:
scripts/mod/file2alias.c:910:39: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  910 | static int do_vmbus_entry(const char *filename, void *symval,
      |                           ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_rpmsg_entry=E2=80=99:
scripts/mod/file2alias.c:927:39: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  927 | static int do_rpmsg_entry(const char *filename, void *symval,
      |                           ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_i2c_entry=E2=80=99:
scripts/mod/file2alias.c:937:37: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  937 | static int do_i2c_entry(const char *filename, void *symval,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_i3c_entry=E2=80=99:
scripts/mod/file2alias.c:946:37: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  946 | static int do_i3c_entry(const char *filename, void *symval,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_spi_entry=E2=80=99:
scripts/mod/file2alias.c:965:37: warning: unused parameter =E2=80=98filenam=
e=E2=80=99
[-Wunused-parameter]
  965 | static int do_spi_entry(const char *filename, void *symval,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_dmi_entry=E2=80=99:
scripts/mod/file2alias.c:1006:37: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1006 | static int do_dmi_entry(const char *filename, void *symval,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_platform_entry=E2=80=99:
scripts/mod/file2alias.c:1030:42: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1030 | static int do_platform_entry(const char *filename,
      |                              ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_mdio_entry=E2=80=99:
scripts/mod/file2alias.c:1038:38: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1038 | static int do_mdio_entry(const char *filename,
      |                          ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_zorro_entry=E2=80=99:
scripts/mod/file2alias.c:1063:39: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1063 | static int do_zorro_entry(const char *filename, void *symval,
      |                           ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_isapnp_entry=E2=80=99:
scripts/mod/file2alias.c:1073:40: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1073 | static int do_isapnp_entry(const char *filename,
      |                            ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_ipack_entry=E2=80=99:
scripts/mod/file2alias.c:1088:39: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1088 | static int do_ipack_entry(const char *filename,
      |                           ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_mips_cdmm_entry=E2=80=99:
scripts/mod/file2alias.c:1178:43: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1178 | static int do_mips_cdmm_entry(const char *filename,
      |                               ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_x86cpu_entry=E2=80=99:
scripts/mod/file2alias.c:1193:40: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1193 | static int do_x86cpu_entry(const char *filename, void *symval,
      |                            ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_cpu_entry=E2=80=99:
scripts/mod/file2alias.c:1212:37: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1212 | static int do_cpu_entry(const char *filename, void *symval, char *a=
lias)
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_mei_entry=E2=80=99:
scripts/mod/file2alias.c:1221:37: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1221 | static int do_mei_entry(const char *filename, void *symval,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_rio_entry=E2=80=99:
scripts/mod/file2alias.c:1239:37: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1239 | static int do_rio_entry(const char *filename,
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_ulpi_entry=E2=80=99:
scripts/mod/file2alias.c:1258:38: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1258 | static int do_ulpi_entry(const char *filename, void *symval,
      |                          ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_hda_entry=E2=80=99:
scripts/mod/file2alias.c:1270:37: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1270 | static int do_hda_entry(const char *filename, void *symval, char *a=
lias)
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_sdw_entry=E2=80=99:
scripts/mod/file2alias.c:1286:37: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1286 | static int do_sdw_entry(const char *filename, void *symval, char *a=
lias)
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_fsl_mc_entry=E2=80=99:
scripts/mod/file2alias.c:1304:40: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1304 | static int do_fsl_mc_entry(const char *filename, void *symval,
      |                            ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_tbsvc_entry=E2=80=99:
scripts/mod/file2alias.c:1315:39: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1315 | static int do_tbsvc_entry(const char *filename, void *symval,
char *alias)
      |                           ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_typec_entry=E2=80=99:
scripts/mod/file2alias.c:1339:39: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1339 | static int do_typec_entry(const char *filename, void *symval,
char *alias)
      |                           ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_tee_entry=E2=80=99:
scripts/mod/file2alias.c:1351:37: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1351 | static int do_tee_entry(const char *filename, void *symval, char *a=
lias)
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_mhi_entry=E2=80=99:
scripts/mod/file2alias.c:1387:37: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1387 | static int do_mhi_entry(const char *filename, void *symval, char *a=
lias)
      |                         ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_ishtp_entry=E2=80=99:
scripts/mod/file2alias.c:1395:39: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1395 | static int do_ishtp_entry(const char *filename, void *symval,
char *alias)
      |                           ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_auxiliary_entry=E2=80=99:
scripts/mod/file2alias.c:1406:43: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1406 | static int do_auxiliary_entry(const char *filename, void
*symval, char *alias)
      |                               ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_ssam_entry=E2=80=99:
scripts/mod/file2alias.c:1419:38: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1419 | static int do_ssam_entry(const char *filename, void *symval,
char *alias)
      |                          ~~~~~~~~~~~~^~~~~~~~
scripts/mod/file2alias.c: In function =E2=80=98do_dfl_entry=E2=80=99:
scripts/mod/file2alias.c:1437:37: warning: unused parameter =E2=80=98filena=
me=E2=80=99
[-Wunused-parameter]
 1437 | static int do_dfl_entry(const char *filename, void *symval, char *a=
lias)
      |                         ~~~~~~~~~~~~^~~~~~~~











> >
> >  scripts/mod/modpost.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 845bc438ca49..843c64eebe8b 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1883,8 +1883,7 @@ static void section_rel(const char *modname, stru=
ct elf_info *elf,
> >   * to find all references to a section that reference a section that w=
ill
> >   * be discarded and warns about it.
> >   **/
> > -static void check_sec_ref(struct module *mod, const char *modname,
> > -                         struct elf_info *elf)
> > +static void check_sec_ref(const char *modname, struct elf_info *elf)
> >  {
> >         int i;
> >         Elf_Shdr *sechdrs =3D elf->sechdrs;
> > @@ -2069,7 +2068,7 @@ static void read_symbols(const char *modname)
> >                                              sym_get_data(&info, sym));
> >         }
> >
> > -       check_sec_ref(mod, modname, &info);
> > +       check_sec_ref(modname, &info);
> >
> >         if (!mod->is_vmlinux) {
> >                 version =3D get_modinfo(&info, "version");
> > --
> > 2.32.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Best Regards
Masahiro Yamada
