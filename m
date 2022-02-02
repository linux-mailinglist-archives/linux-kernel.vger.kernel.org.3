Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B1D4A7BF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbiBBXyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:54:23 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:36152
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232679AbiBBXyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846060; bh=2TKlO8lwTSoq//My5UUY9CgrF2k3PcalEUhKrPWoC6A=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=jiL4AzSVs3JgCLIG8FBZzTRYjk2zaJktr8a7lgYaFm2De77ZLfN6gCAZAd/6DzCZ9K2FOKcOITLXkpMcAACeioTJG5OeefCq/67oR0yNMMoY9Lt6mSZQyGE/xOGP3HvA9ipE2pyj5fgirxMbPDi54DaDAZR87z3wV9SWNLNIKyJrlJ0RhkPcuEhfN6pbmCkKFJENkyBkZQ5nXTYPDkNLox2yEmPLmFm9o03zT54F45KXveV8Fmb6K7iogKa3LXLDdM3LfjnYCHVUC+oUljqJxV5FzH3Xh853SODiwHSDAnddrzNzfagNj6CZRO0i7+rEQDZniFgMiylHVKAtpOnh/w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846060; bh=MzsDfWk7CLi9B8GAYwPAjUb99trMqEa1WPCx4f8EsBA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=H72Z0w1CPKuGuu6/f/Omf1W0+6QcJxpJZmnURCpop3yfjv5m4P2TXanmTJK3+xoFbDYYevYN7s1PzGgqml+67UFsAORC134uAIOQFWzjNpv59Aq732VxmUnEDIL+xRd3prm9QbrKBpzWKF/uDFHeXjbQYicAyQcLxPo+47QCjI/h/y9Bkc4wtmikSCGmEm9iPqaWuUVYMhXS1XRKQaJQitk13oah3GrA2Eh39Bzg24M5MaOaIAhVP/nfUCo9Q14zbHnPBIzynJCjCBfJRHnHUwM3epXVH0N6BQEyAOLjAUl0jIxl/9phAsIVPMPynPENOMDdKSO0hq+eLFSmal+kag==
X-YMail-OSG: 5nlOtW0VM1lz90FgZfgm9v3V_GTfc5FbT0W.jDsbhyi.6Q_K.jmYkX72v6X0v6x
 ls0bkR0y9M4r8GN.53IXb8j68TZXWED3TdrKkTJfLqkNkvFo1BHnE1.XFpt12hb1ip_mvq3gIQrU
 InsuzeBZT5weE.MUJdl6ZAXYwemy8Idp8.9De.iPwFeVnC_TrbbvXN5sr3SvE3puJdfNCq0p9dpX
 73Ud84MxxdHHgPpokC5Uu_6SBEGnFGq1.47aGqma8uiJ0Q6HTL7x8YEAU4Dv_daTsvgpHBM2PDtT
 R7x72uDDwxaXdRkp85s1SMpyJHO.gS_3_gf1KXeZyoPHvlbeHQKj1q347yBKN6CLbM0J4MFetooL
 hT0VZk0oOyF.AVqjWgymwF9o0sZnRMl_ChlRrtXHDKWrI7q3tmyXC4naPqbmruDbBgSx6u1kfqS5
 33F1h9TyaOjBKFgae0sGrjbdRudMEcNCrMAQMceqdanNA22SpiWPpO3l8.kVCTVCbqy4kiJ4W2Qt
 g3fhXaz7OqqpLd3slLhq_4fPF22Dh8376f0YSyC8FECw.JTaeA1TmjCisS_zYhVoxK9cLQeSffb2
 FIiV0b1N8ptsq_h_qOl4oxy664jC2FZNv.NyKtgjJanEquxNHaIPNurQ1Qtfa1r617DtqCACaOQZ
 9d_x4HUcUQ.Ax5jebNGOAbcjWrTCIUp6uMkwu8x_dLsMudGzrAxrq1PAVEkESD3C30i78zGPoH0k
 CvaHpuyVi8mslETyZ8d4Ti48fFJ3o.gFsrDwd7LdJWVk.WvA2X.lJ1glTNDMWn0G6M8HXfZuxjBb
 1BYx746hNT09HXLyOUMQAUlVPDHT_GKCGDvDoGxp4olB_st7503mDBGLrAzI8BZG3sFa0OIFGipZ
 6yGO70ggDzksMlPiHSbKHglNgnf7Z8wQ8aTPrSbRhnhSQdwzv6D6LnOQ76vgTrbn9b3aN5VQImb2
 KBl6.Bj5zt64biMTKlGQf3pDwwdZZaQ85mg9kTQsMzDGFqJz.Zvh8AcRvEeJ91Mqq6cPm2aselu.
 0yhm6jPXaYOuy8ag1_7l1YM4HBulKmE957za4IpZo76_VuCSzL9rY9rUd88k_leAnHwy6_.hFk.x
 7OPHZHdPpgBLGY46CxMqaA6YWDZyHdGi_LGi6nt0RM46iIdwqfL4p5TY2X9hswseJ6K6YFhP7zsn
 k9ZEo8ktcOFONxm30Z904SuRd3W9uiuM8GRCU.yQn5VUiRC7t96QmDYsQFc4hxiAVG_CVOPoaSEG
 EOKi8AvGapjZBVlNgp7mQ1m_4VedRfg8NqmgEcMbiBUhN2mF.V1xlBxpSSoJek.i2I3Wy_dxu462
 h7ekKDgxj8FmFzigoYiUXSi0BoRZISfwDZTDtCISh78zRr7Y5KDpBePtWiDEfK.iKPMCafs6U9Ul
 o6Yhzfv.UVlziJD7O_DjsERrz9l.ftXCwOYuJtkSgWkaCWaiyqPGdQBqBKzErYcqSgbxudTBcIcZ
 LieW3iwrPMT3FQm40dselv6tlmM1WLhXVSvm36nJbb4MdUM1kTpmWLue3YDKB9CwWkUxsRWYESzb
 S98uwcoIQJQe1DqFTytPi_PRf0_C5FoqEXMV1bcrxU3ihx2wBR4eD36ABr6uSEkd5sYVjxMNXJAd
 _kQl50IpiCvaq2Iq8OIx.rkjBaz3qWFuuBMy.3Xzld9BMCqHl5hyewBFzNPc25ds8nNNAHJpIisE
 W5X2E8APKphR2s.JcVQNdAIfQWi8oCci2XVNlG3KFMxruFx53VVzpRxHdQ0XKou3Zr5DC2kWOF0E
 czEhWabdVDY215Pvfrjced1xMdqUWA.kFISUUicIliFeOFnvwdG_eIcIkG3kwHk4wWk9ahcSuBGv
 7IlggUrddHDM0M.8fj9t9XPbDaj3T1v9uxrlkTKjrjYxg7QUtbFDNYXwuJN0OlTGCEuyCNIkpHHM
 wvtRMdXxFBtU0RWwBux5AIQwsTevMhAsYVYYZy6hxwHABXsfgiYrTPrZMuDhnZlW4wUtGh_XPZrA
 M6qRiJOtHdU6ldF3tuo7.0VckgQIO90Gx9RdedAPeNyk3iQTdD7U8y6QaSWbUMBizrRkwI.ZBYPF
 ti3uIX46gZHEfOcqoZLFvZ8jEpD_4gJvtFM34KCaexGmV3lHt_MqM.CN4znAuceYC_UMx9j69JzS
 PtIbiCl8X4CGils5UknJ3Hp1wMme0VDrskZSWbfl2yJDFXIzzIutDEi_p._FV2yKGeZQq.CvwZJv
 wvBDKe9CAmtF6t42nWuNwY_kAfi8Lkleo9zwSv1SDzDU4dAkUc3YUBWQjNfv_I6jRmQr5T6YehRq
 aFpuaM8V_wISHYVZuKqS2m6dp
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Feb 2022 23:54:20 +0000
Received: by kubenode539.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID feaf070e5149ea1d80a071ec8c4c88dd;
          Wed, 02 Feb 2022 23:54:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 00/28] LSM: Module stacking for AppArmor
Date:   Wed,  2 Feb 2022 15:52:55 -0800
Message-Id: <20220202235323.23929-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20220202235323.23929-1-casey.ref@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v32: Rebase to 5.17-rc2
     Incorporate additional feedback from v30.
v31: Rebase to 5.16-rc4
     Incorporate feedback from Paul Moore on the audit
     component changes.
v30: Rebase to 5.16-rc1
     Replace the integrity sub-system reuse of the audit
     subsystem event matching functions with IMA specific
     functions. This is done because audit needs to maintain
     information about multiple security modules in audit
     rules while IMA to restricts the information to a single
     security module.
     The binder hooks have been changed and are no longer
     called with sufficient information to identify the
     interface_lsm. Pass that information in the binder
     message, and use that in the compatibility decision.
     Refactor the audit changes.
v29: Rebase to 5.15-rc1
     Rework the supplimental audit record generation. Attach
     a list of supplimental data to the audit_buffer and
     generate the auxiliary records as needed on event end.
     This should be usable for other auxiliary data, such as
     container IDs. There is other ongoing audit work that
     will require integration with this.
v28: Rebase to 5.14-rc2
     Provide IMA rules bounds checking (patch 04)
     Quote contexts in MAC_TASK_CONTEXTS and MAC_OBJ_CONTEXTS
     audit records because of AppArmor's use of '=' in context
     values. (patch 22,23)
v27: Fixes for landlock (patch 02)
     Rework the subject audit record generation. This version is
     simpler and reflects feedback from Paul Moore. (patch 22)
v26: Rebase to 5.13-rc1
     Include the landlock security module.
     Accomodate change from security_task_getsecid() to
     security_task_getsecid_obj() and security_task_getsecid_subj().
v25: Rebase to 5.12-rc2
     Incorporate feedback from v24
     - The IMA team suggested improvements to the integrity rule
       processing.
v24: Rebase to 5.11-rc1
     Incorporate feedback from v23
     - Address the IMA team's concerns about "label collisions".
       A label collision occurs when there is ambiguity about
       which of multiple LSMs is being targeted in the definition
       of an integrity check rule.  A system with Smack and
       AppArmor would be unable to distinguish which LSM is
       important to an integrity rule referrencing the label
       "unconfined" as that label is meaningful to both.
       Provide a boot option to specify which LSM will be used in
       IMA rules when multiple LSMs are present. (patch 04)
       Pull LSM "slot" identification from later audit patches in
       in support of this (patch 03).
     - Pick up a few audit events that need to include supplimental
       subject context records that had been missed in the
       previous version.
v23: Rebase to 5.10-rc4
     Incorporate feedback from v22
     - Change /proc/*/attr/display to /proc/*/attr/interface_lsm to
       make the purpose clearer. (patch 0012)
     - Include ABI documentation. (patch 0012, 0022)
     - Introduce LSM documentation updates with the patches where
       the interfaces are added rather than at the end. (patch 0012, 0022)
     Include more maintainers and mail lists in To: and Cc: directives.
v22: Rebase to 5.10-rc1
v21: Rebase to 5.9-rc4
     Incorporate feedback from v20
     - Further revert UDS SO_PEERSEC to use scaffolding around
       the interfaces that use lsmblobs and store only a single
       secid. The possibility of multiple security modules
       requiring data here is still a future problem.
     - Incorporate Richard Guy Briggs' non-syscall auxiliary
       records patch (patch 0019-0021) in place of my "supplimental"
       records implementation. [I'm not sure I've given proper
       attestation. I will correct as appropriate]
v20: Rebase to 5.9-rc1
     Change the BPF security module to use the lsmblob data. (patch 0002)
     Repair length logic in subject label processing (patch 0015)
     Handle -EINVAL from the empty BPF setprocattr hook (patch 0020)
     Correct length processing in append_ctx() (patch 0022)
v19: Rebase to 5.8-rc6
     Incorporate feedback from v18
     - Revert UDS SO_PEERSEC implementation to use lsmblobs
       directly, rather than allocating as needed. The correct
       treatment of out-of-memory conditions in the later case
       is difficult to define. (patch 0005)
     - Use a size_t in append_ctx() (patch 0021)
     - Fix a memory leak when creating compound contexts. (patch 0021)
     Fix build error when CONFIG_SECURITY isn't set (patch 0013)
     Fix build error when CONFIG_SECURITY isn't set (patch 0020)
     Fix build error when CONFIG_SECURITY isn't set (patch 0021)
v18: Rebase to 5.8-rc3
     Incorporate feedback from v17
     - Null pointer checking in UDS (patch 0005)
     Match changes in IMA code (patch 0012)
     Fix the behavior of LSM context supplimental audit
     records so that there's always exactly one when it's
     appropriate for there to be one. This is a substantial
     change that requires extention of the audit_context beyond
     syscall events. (patch 0020)
v17: Rebase to 5.7-rc4
v16: Rebase to 5.6
     Incorporate feedback from v15 - Thanks Stephen, Mimi and Paul
     - Generally improve commit messages WRT scaffolding
     - Comment ima_lsm_isset() (patch 0002)
     - Some question may remain on IMA warning (patch 0002)
     - Mark lsm_slot as __lsm_ro_after_init not __init_data (patch 0002)
     - Change name of lsmblob variable in ima_match_rules() (patch 0003)
     - Instead of putting a struct lsmblob into the unix_skb_parms
       structure put a pointer to an allocated instance. There is
       currently only space for 5 u32's in unix_skb_parms and it is
       likely to get even tighter. Fortunately, the lifecycle
       management of the allocated lsmblob is simple. (patch 0005)
     - Dropped Acks due to the above change (patch 0005)
     - Improved commentary on secmark labeling scaffolding. (patch 0006)
     - Reduced secmark related labeling scaffolding. (patch 0006)
     - Replace use of the zeroth entry of an lsmblob in scaffolding
       with a function lsmblob_value() to hopefully make it less
       obscure. (patch 0006)
     - Convert security_secmark_relabel_packet to use lsmblob as
       this reduces much of the most contentious scaffolding. (patch 0006)
     - Dropped Acks due to the above change (patch 0006)
     - Added BUILD_BUG_ON() for CIPSO tag 6. (patch 0018)
     - Reworked audit subject information. Instead of adding fields in
       the middle of existing records add a new record to the event. When
       a separate record is required use subj="?". (patch 0020)
     - Dropped Acks due to the above change (patch 0020)
     - Reworked audit object information. Instead of adding fields in
       the middle of existing records add a new record to the event. When
       a separate record is required use obj="?". (patch 0021)
     - Dropped Acks due to the above change (patch 0021)
     - Enhanced documentation (patch 0022)
     - Removed unnecessary error code check in security_getprocattr()
       (patch 0021)
v15: Rebase to 5.6-rc1
     - Revise IMA data use (patch 0002)
     Incorporate feedback from v14
     - Fix lockdown module registration naming (patch 0002)
     - Revise how /proc/self/attr/context is gathered. (patch 0022)
     - Revise access modes on /proc/self/attr/context. (patch 0022)
     - Revise documentation on LSM external interfaces. (patch 0022)
v14: Rebase to 5.5-rc5
     Incorporate feedback from v13
     - Use an array of audit rules (patch 0002)
     - Significant change, removed Acks (patch 0002)
     - Remove unneeded include (patch 0013)
     - Use context.len correctly (patch 0015)
     - Reorder code to be more sensible (patch 0016)
     - Drop SO_PEERCONTEXT as it's not needed yet (patch 0023)
v13: Rebase to 5.5-rc2
     Incorporate feedback from v12
     - Print lsmblob size with %z (Patch 0002)
     - Convert lockdown LSM initialization. (Patch 0002)
     - Restore error check in nft_secmark_compute_secid (Patch 0006)
     - Correct blob scaffolding in ima_must_appraise() (Patch 0009)
     - Make security_setprocattr() clearer (Patch 0013)
     - Use lsm_task_display more widely (Patch 0013)
     - Use passed size in lsmcontext_init() (Patch 0014)
     - Don't add a smack_release_secctx() hook (Patch 0014)
     - Don't print warning in security_release_secctx() (Patch 0014)
     - Don't duplicate the label in nfs4_label_init_security() (Patch 0016)
     - Remove reviewed-by as code has significant change (Patch 0016)
     - Send the entire lsmblob for Tag 6 (Patch 0019)
     - Fix description of socket_getpeersec_stream parameters (Patch 0023)
     - Retain LSMBLOB_FIRST. What was I thinking? (Patch 0023)
     - Add compound context to LSM documentation (Patch 0023)
v12: Rebase to 5.5-rc1
     Fixed a couple of incorrect contractions in the text.
v11: Rebase to 5.4-rc6
     Incorporate feedback from v10
     - Disambiguate reading /proc/.../attr/display by restricting
       all use of the interface to the current process.
     - Fix a merge error in AppArmor's display attribute check
v10: Ask the security modules if the display can be changed.
v9: There is no version 9
v8: Incorporate feedback from v7
    - Minor clean-up in display value management
    - refactor "compound" context creation to use a common
      append_ctx() function.
v7: Incorporate feedback from v6
    - Make setting the display a privileged operation. The
      availability of compound contexts reduces the need for
      setting the display.
v6: Incorporate feedback from v5
    - Add subj_<lsm>= and obj_<lsm>= fields to audit records
    - Add /proc/.../attr/context to get the full context in
      lsmname\0value\0... format as suggested by Simon McVittie
    - Add SO_PEERCONTEXT for getsockopt() to get the full context
      in the same format, also suggested by Simon McVittie.
    - Add /sys/kernel/security/lsm_display_default to provide
      the display default value.
v5: Incorporate feedback from v4
    - Initialize the lsmcontext in security_secid_to_secctx()
    - Clear the lsmcontext in all security_release_secctx() cases
    - Don't use the "display" on strictly internal context
      interfaces.
    - The SELinux binder hooks check for cases where the context
      "display" isn't compatible with SELinux.
v4: Incorporate feedback from v3
    - Mark new lsm_<blob>_alloc functions static
    - Replace the lsm and slot fields of the security_hook_list
      with a pointer to a LSM allocated lsm_id structure. The
      LSM identifies if it needs a slot explicitly. Use the
      lsm_id rather than make security_add_hooks return the
      slot value.
    - Validate slot values used in security.c
    - Reworked the "display" process attribute handling so that
      it works right and doesn't use goofy list processing.
    - fix display value check in dentry_init_security
    - Replace audit_log of secids with '?' instead of deleting
      the audit log
v3: Incorporate feedback from v2
    - Make lsmblob parameter and variable names more
      meaningful, changing "le" and "l" to "blob".
    - Improve consistency of constant naming.
    - Do more sanity checking during LSM initialization.
    - Be a bit clearer about what is temporary scaffolding.
    - Rather than clutter security_getpeersec_dgram with
      otherwise unnecessary checks remove the apparmor
      stub, which does nothing useful.

Patch 01 separates the audit rule processing from the
integrity rule processing. They were never really the
same, but void pointers could hide that. The changes
following use the rule pointers differently in audit
and IMA, so keeping the code common is not a good idea.

Patch 02 moves management of the sock security blob
from the individual modules to the infrastructure.

Patches 03-04 introduce a structure "lsmblob" that will gradually
replace the "secid" as a shorthand for security module information.
At this point lsmblob contains an array of u32 secids, one "slot"
for each of the security modules compiled into the kernel that
used secids. A "slot" is allocated when a security module requests
one.

Patch 05 provides mechanism for the IMA subsystem to identify
explicitly which LSM is subject to IMA policy. This includes
a boot option for specifying the default and an additional option
in IMA rules "lsm=".

Patches 06-15 change LSM interfaces to use the lsmblob instead
of secids. It is important that the lsmblob be a fixed size entity
that does not have to be allocated. Several of the places
where it is used would have performance and/or locking
issues with dynamic allocation.

Patch 15 provides a mechanism for a process to identify which
security module's hooks should be used when displaying or
converting a security context string.  A new interface
/proc/self/attr/interface_lsm contains the name of the security
module to show. Reading from this file will present the name of
the module, while writing to it will set the value. Only names
of active security modules are accepted. Internally, the name
is translated to the appropriate "slot" number for the module
which is then stored in the task security blob. Setting the
display requires that all modules using the /proc interfaces
allow the transition. The interface LSM of other processess
can be neither read nor written. All suggested cases for
reading the interface LSM of a different process have race
conditions.

Patch 16 Starts the process of changing how a security
context is represented. Since it is possible for a
security context to have been generated by more than one
security module it is now necessary to note which module
created a security context so that the correct "release"
hook can be called. There are several places where the
module that created a security context cannot be inferred.

This is achieved by introducing a "lsmcontext" structure
which contains the context string, its length and the
"slot" number of the security module that created it.
The security_release_secctx() interface is changed,
replacing the (string,len) pointer pair with a lsmcontext
pointer.

Patches 17-18 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

The Netlabel code is converted to save lsmblob structures
instead of secids in Patch 19. This is not strictly
necessary as there can only be one security module that
uses Netlabel at this point. Using a lsmblob is much
cleaner, as the interfaces that use the data have all
been converted.

Patch 20 adds checks to the binder hooks which verify
that both ends of a transaction use the same interface LSM.

Patch 21 adds a parameter to security_secid_to_secctx()
that indicates which of the security modules should be used
to provide the context.

Patches 22-24 provide mechanism to keeping a list of auxiliary
record data in an audit_buffer. The list is read when the
audit record is ended, and supplimental records are created
as needed.

Patch 25 adds a supplimental audit record for subject
LSM data when there are multiple security modules with such data.
The AUDIT_MAC_TASK_CONTEXTS record is used in conjuction with a
"subj=?" field to identify the subject data. The
AUDIT_MAC_TASK_CONTEXTS record identifies the security module
with the data: subj_selinux="xyz_t" subj_apparmor="abc".

An example of the MAC_TASK_CONTEXTS (1420) record is:

    type=UNKNOWN[1420]
    msg=audit(1600880931.832:113)
    subj_apparmor==unconfined
    subj_smack=_

Patch 26 adds a supplimental audit record for object
LSM data when there are multiple security modules with such data.
The AUDIT_MAC_OBJ_CONTEXTS record is used in conjuction The
with a "obj=?" field to identify the object data.
The AUDIT_MAC_OBJ_CONTEXTS record identifies the security module
with the data: obj_selinux="xyz_t obj_apparmor="abc".  While
AUDIT_MAC_TASK_CONTEXTS records will always contain an entry
for each possible security modules, AUDIT_MAC_OBJ_CONTEXTS
records will only contain entries for security modules for
which the object in question has data.

An example of the MAC_OBJ_CONTEXTS (1421) record is:

    type=UNKNOWN[1421]
    msg=audit(1601152467.009:1050):
    obj_selinux=unconfined_u:object_r:user_home_t:s0

Patch 27 adds a new interface for getting the compound security
contexts, /proc/self/attr/context.  An example of the content
of this file is:

    selinux\0one_u:one_r:one_t:s0-s0:c0.c1023\0apparmor\0unconfined\0

Finally, with all interference on the AppArmor hooks removed,
Patch 28 removes the exclusive bit from AppArmor. An unnecessary
stub hook was also removed.

The Ubuntu project is using an earlier version of this patchset in
their distribution to enable stacking for containers.

Performance measurements to date have the change within the "noise".
The sockperf and dbench results are on the order of 0.2% to 0.8%
difference, with better performance being as common as worse. The
benchmarks were run with AppArmor and Smack on Ubuntu.

https://github.com/cschaufler/lsm-stacking.git#stack-5.17-rc2-v32

Casey Schaufler (28):
  integrity: disassociate ima_filter_rule from security_audit_rule
  LSM: Infrastructure management of the sock security
  LSM: Add the lsmblob data structure.
  LSM: provide lsm name and id slot mappings
  IMA: avoid label collisions with stacked LSMs
  LSM: Use lsmblob in security_audit_rule_match
  LSM: Use lsmblob in security_kernel_act_as
  LSM: Use lsmblob in security_secctx_to_secid
  LSM: Use lsmblob in security_secid_to_secctx
  LSM: Use lsmblob in security_ipc_getsecid
  LSM: Use lsmblob in security_current_getsecid
  LSM: Use lsmblob in security_inode_getsecid
  LSM: Use lsmblob in security_cred_getsecid
  LSM: Specify which LSM to display
  LSM: Ensure the correct LSM context releaser
  LSM: Use lsmcontext in security_secid_to_secctx
  LSM: Use lsmcontext in security_inode_getsecctx
  LSM: security_secid_to_secctx in netlink netfilter
  NET: Store LSM netlabel data in a lsmblob
  binder: Pass LSM identifier for confirmation
  LSM: Extend security_secid_to_secctx to include module selection
  Audit: Keep multiple LSM data in audit_names
  Audit: Create audit_stamp structure
  Audit: Add framework for auxiliary records
  Audit: Add record for multiple task security contexts
  Audit: Add record for multiple object security contexts
  LSM: Add /proc attr entry for full LSM context
  AppArmor: Remove the exclusive flag

 Documentation/ABI/testing/ima_policy          |   8 +-
 .../ABI/testing/procfs-attr-lsm_display       |  22 +
 Documentation/security/lsm.rst                |  28 +
 drivers/android/binder.c                      |  47 +-
 drivers/android/binder_internal.h             |   1 +
 fs/ceph/xattr.c                               |   6 +-
 fs/nfs/nfs4proc.c                             |   8 +-
 fs/nfsd/nfs4xdr.c                             |  20 +-
 fs/proc/base.c                                |   2 +
 include/linux/audit.h                         |  15 +-
 include/linux/cred.h                          |   3 +-
 include/linux/lsm_hooks.h                     |  19 +-
 include/linux/security.h                      | 243 ++++++-
 include/net/netlabel.h                        |   8 +-
 include/net/scm.h                             |  15 +-
 include/uapi/linux/audit.h                    |   2 +
 kernel/audit.c                                | 250 +++++--
 kernel/audit.h                                |  17 +-
 kernel/auditfilter.c                          |  29 +-
 kernel/auditsc.c                              | 128 ++--
 kernel/cred.c                                 |  12 +-
 net/ipv4/cipso_ipv4.c                         |  26 +-
 net/ipv4/ip_sockglue.c                        |  12 +-
 net/netfilter/nf_conntrack_netlink.c          |  24 +-
 net/netfilter/nf_conntrack_standalone.c       |  11 +-
 net/netfilter/nfnetlink_queue.c               |  38 +-
 net/netfilter/nft_meta.c                      |  10 +-
 net/netfilter/xt_SECMARK.c                    |   7 +-
 net/netlabel/netlabel_kapi.c                  |   6 +-
 net/netlabel/netlabel_unlabeled.c             | 101 ++-
 net/netlabel/netlabel_unlabeled.h             |   2 +-
 net/netlabel/netlabel_user.c                  |  13 +-
 net/netlabel/netlabel_user.h                  |   6 +-
 security/apparmor/include/apparmor.h          |   3 +-
 security/apparmor/include/net.h               |   6 +-
 security/apparmor/include/procattr.h          |   2 +-
 security/apparmor/lsm.c                       | 105 +--
 security/apparmor/procattr.c                  |  22 +-
 security/bpf/hooks.c                          |  12 +-
 security/commoncap.c                          |   7 +-
 security/integrity/ima/ima.h                  |  26 -
 security/integrity/ima/ima_appraise.c         |  12 +-
 security/integrity/ima/ima_main.c             |  63 +-
 security/integrity/ima/ima_policy.c           |  58 +-
 security/landlock/cred.c                      |   2 +-
 security/landlock/fs.c                        |   2 +-
 security/landlock/ptrace.c                    |   2 +-
 security/landlock/setup.c                     |   5 +
 security/landlock/setup.h                     |   1 +
 security/loadpin/loadpin.c                    |   8 +-
 security/lockdown/lockdown.c                  |   7 +-
 security/safesetid/lsm.c                      |   8 +-
 security/security.c                           | 615 ++++++++++++++++--
 security/selinux/hooks.c                      |  99 +--
 security/selinux/include/classmap.h           |   3 +-
 security/selinux/include/objsec.h             |   5 +
 security/selinux/include/security.h           |   1 +
 security/selinux/netlabel.c                   |  25 +-
 security/selinux/ss/services.c                |   4 +-
 security/smack/smack.h                        |   6 +
 security/smack/smack_access.c                 |   2 +-
 security/smack/smack_lsm.c                    |  91 +--
 security/smack/smack_netfilter.c              |   4 +-
 security/smack/smackfs.c                      |  10 +-
 security/tomoyo/tomoyo.c                      |   8 +-
 security/yama/yama_lsm.c                      |   7 +-
 66 files changed, 1746 insertions(+), 624 deletions(-)
 create mode 100644 Documentation/ABI/testing/procfs-attr-lsm_display

-- 
2.31.1

