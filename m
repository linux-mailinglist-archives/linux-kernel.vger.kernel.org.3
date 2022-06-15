Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829C654C874
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbiFOM1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiFOM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:27:06 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9353F8AF;
        Wed, 15 Jun 2022 05:27:05 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id d39so11670325vsv.7;
        Wed, 15 Jun 2022 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwvrSBY0K1lxI0C2vn2XWEuKhMJp/81wxnmOsvTEpts=;
        b=j8BSGoa3l8HP7Fyry3LI9PJLeumQFEqqkB9FTbXduzWihu9eBdYh9QIv8Rap153I45
         3WyBCm7zbbrUbkrbWZ2dV9sioE7+02YlaYsPYYjoZlChzRdLbsIA/FkRp2QQyjrtr0+p
         TEwQo3Q5arJG3LERiiM1ZIXpWeGWfFoF3byRKf/86Hf7kVTvZcK+6g8lfOwRwtce/1yw
         k6d8m9TegyUjwyiYMRQy52LIajVGhZu4l8mrtOeESRHpuek/VEWk/ECGPqeMtTmnHTNb
         xG0Tu2pxGJqeC+C5SCvtCoH04PFjQb8Sf78PFX6VhunarRes8pTZBoLBcwmZQ7KKto2h
         cpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwvrSBY0K1lxI0C2vn2XWEuKhMJp/81wxnmOsvTEpts=;
        b=TDSbthD4AC2ZwqmkWu5xDfQPwwuPH1KrbkWAT3nDhUdiYbsRPxKinIfZCHFZ+iLZhc
         JwLfWUkT5CNqmTCZyXSIOfJRdJX2esBs5yGAoBL0miH8WkIVLzPqSACD67Ug5jbf9hK6
         GiIeBZs1sg9/k6qKFdYRxQRXsXdGBBmhtpaFqL+0J9r+/DJ7Xk/vqVWX52XsFLMQ6zZD
         tVUTwjjNm1wZjmczwi3kr9deveqFoTgN4n6n+RKwgRCudT9B8TZlCyLbAJQbPsW9agC3
         TucqSz5u9ozDktCgGQv8zHqF2stqCFdg1qrWhqVrFqwAml9AJ2ocOi+Jir8bEVOH3BB1
         4IWQ==
X-Gm-Message-State: AJIora8wJEKD4uYl75ROPn2SCNqn1pMnSp2LFFhvlpsex8bM/xQqGqw3
        jXK5d9EstLJRZxJ2utjFwagUGdCV7FKCLlJG/Z09XwO4m2E=
X-Google-Smtp-Source: AGRyM1vIID4hfv/xDYq+lm4x1x/xTwUXy4ssm6cGjJFZ69//GdZLq9YW7AGi1aWUSzePokk3toA/CxuotKkORBCDB2w=
X-Received: by 2002:a67:6d42:0:b0:34b:94e4:55f6 with SMTP id
 i63-20020a676d42000000b0034b94e455f6mr4444836vsc.6.1655296024326; Wed, 15 Jun
 2022 05:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220615082348.3e55ec40@canb.auug.org.au>
In-Reply-To: <20220615082348.3e55ec40@canb.auug.org.au>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 15 Jun 2022 14:26:47 +0200
Message-ID: <CAOi1vP-FXAe-idjM4Opb24fv2Qbxg31Z36UUXeqTiFoEvJCasg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the ceph tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 12:23 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   39be3f3c2896 ("fscrypt: add fscrypt_context_for_new_inode")
>   93d0d0af009d ("fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size")
>
> are missing a Signed-off-by from their committer.

My bad, now fixed.

Thanks,

                Ilya
