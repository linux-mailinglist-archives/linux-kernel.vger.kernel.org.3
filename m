Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC8518BD4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbiECSJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiECSIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:08:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DEFC09
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:05:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d5so24423846wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q5Dh8zgUF+clDDSF4VJ71yjlCuqjR+QuFSNc95HoPCs=;
        b=LvqrGYRNFNkrxBlEuy5c/zuS8vKuWBFXcpcCPpSscv+hFrPesQkBuhou2fFMXMedXc
         QAnmeh1vQPQoYwaH40pFmnXdhzBNeueUKtHD1iosqL9Bdj4yBzY1U8tcQSY2Rygx2URB
         FtOsUvogM3ihUuW+M08v6tAL+6t79Th4ATBFND8ZnfpUKBoKIy16q2m9XgSBxxTzzqpD
         2729ITSbTdVfJinehMGA2k7k7Qyh4qnXkWfoIaDB7u67+4qJtf5jz7IUOrXQtFFy33jO
         6qBcE4j7fD7VX9d9AbBo3MAeVwU5Ro5yo7UJOwEkl4A9OcgX6QSEsWv/138yCRTbaeIk
         LMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q5Dh8zgUF+clDDSF4VJ71yjlCuqjR+QuFSNc95HoPCs=;
        b=m8dP57WF6qwco37x0bwj/1tE6qDgVSHx9OALgsaitwXmSQo8mGmLRPYM8PD7ZWQZDp
         Vhz+M9eO/xGoa4hM/EDRp8yrxn+LoAL7FRNZaHgY2SxL/+ymEzcYD6ceCmb3HIRz9tEv
         DCaO0hkajb7FIsROn6BihAGq+FWaB5fPy9CkB2kXuJplixnws2rq7jTB5K7NvSD88PfB
         iGLX9nui8rPV/eD1HxZB7mJn/X8cCujT2N0oHuWAA1MEYGqt21lrF+/kOgN/9OCXyyBF
         vfKEP+qBT+Vv4ihElpQVU7dA4fKoqXxG2AH3RKSPl8F7RbIxdSjdCe0jJWyAvNdunWFv
         YyxQ==
X-Gm-Message-State: AOAM530XNuefVrWSQMclQZ2/d6EflT+lSwVlj4ubj1nS2eaLP9Ppu8rq
        X1mWxzVMQj0g/RzKlKH3l+CD0pph/4fYXbmRiTV/
X-Google-Smtp-Source: ABdhPJxBqUmGOvsLySN0azIzOT79wpo0DOyC75YwVDOzLW0yJk7R3yP7kP+yA0942vDh6Gu59IJFVmLZGHoGZQ86F9Q=
X-Received: by 2002:a05:6000:80e:b0:20c:5b45:a700 with SMTP id
 bt14-20020a056000080e00b0020c5b45a700mr10038995wrb.662.1651601116141; Tue, 03
 May 2022 11:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220502140151.31767-1-cgzones@googlemail.com>
In-Reply-To: <20220502140151.31767-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 14:05:05 -0400
Message-ID: <CAHC9VhQDKVrG7ob1PTH6MF9k7Kdcy+7SBsOYU9XEZv79Zt_ceQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: update parameter documentation
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 10:02 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> security/selinux/include/audit.h:54: warning: Function parameter or membe=
r 'krule' not described in 'selinux_audit_rule_known'
> security/selinux/include/audit.h:54: warning: Excess function parameter '=
rule' description in 'selinux_audit_rule_known'
> security/selinux/include/avc.h:130: warning: Function parameter or member=
 'state' not described in 'avc_audit'
>
> This also bring the parameter name of selinux_audit_rule_known() in sync
> between declaration and definition.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/audit.h | 2 +-
>  security/selinux/include/avc.h   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks!

--=20
paul-moore.com
