Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2685874EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiHBA4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHBAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:55:57 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07D402C4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:55:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n138so9664552iod.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htjvkGtQpD6Ib4OiEIrcN6xIzNKXkccUpXIUMoKCYKE=;
        b=LbddkIraI5kkZn728C1TSSYy5FguP7AYKDzT0VdOo2sH0YCa/ykzKNIxF5+bY4i+Qr
         GKIQKZX0wpnvX36KEgM7HkjtSE62AKJKKCBhanG6gKWSq2alQ7XCYsq96FIY5a+kgGvL
         TlrHefU1yOJbYAX9bUBqcV6J6couXv9Hbfm9IvVoKcEf9HtJm9Mz6SCzPWz15nRi+jln
         yejT6JbgQdqtOX/16ZaERVHMxOs76BzuJchiiUoNm64gtNSGm9ndu8cu8CRJZYU5jGWy
         lYW8WwzRFum5g5hL8p7pUgDoAFlH2yijUUp4uyVsGObYLvnnQeHTtA6zEe8mtd4UoYUY
         Edag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htjvkGtQpD6Ib4OiEIrcN6xIzNKXkccUpXIUMoKCYKE=;
        b=Qw/4TQJrPItbpisirR1CGghA2qtEg6wePwk5ganwYyuge/IotifO2thheGWpDMZj4/
         VjxWh31ukyXrTUstIgzPbxT4ppaxMq7TsHF2yJheVWz6erb3IVqPyw0QsI4jmL+14v8s
         Oirw03a3MHpt3tW7PESIxDBWgsSq2imnvX2sa0gRz531x7aatpzdr7Pcgxi618wtqXF7
         ZHXZWaIS+0EjKht0tH8W3BdXQK2BSQtuF5BfzruQgxeB1rF2vvy3hdGct/69ifH87j/R
         x9LBX1X0gJ+je/u4BZtRIIuPQrSyC4qvIJ4NRdgOBE9PdoH/KPb5LwirPHTfsLjFcL5t
         CsCw==
X-Gm-Message-State: AJIora/q2C2Sw1/WilwX7+oJKNc0F2TBZzW0twU2L8rSbXapXhv5qG20
        D7PivMIOk8PShzf4LKD2aE+AFC5MYD2wLrvx60E=
X-Google-Smtp-Source: AGRyM1sk7GvHka1gHmx27XQxq4PxeYaRf5VgpXSGDETtSipaNEzwr+0ExJdTormVztKqYE/ZhiJxqtCoFr6mIGeLyfg=
X-Received: by 2002:a05:6638:4108:b0:33f:88e3:ccec with SMTP id
 ay8-20020a056638410800b0033f88e3ccecmr7763064jab.264.1659401755165; Mon, 01
 Aug 2022 17:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <202207281950.xaFXiPzC-lkp@intel.com> <383b1045-94c5-c2b0-57db-9f4f4760206c@intel.com>
In-Reply-To: <383b1045-94c5-c2b0-57db-9f4f4760206c@intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Aug 2022 02:55:44 +0200
Message-ID: <CANiq72ma-c5PjWSLOp3PwonLfkNp83csM=1EfzSPEr+QG-szzg@mail.gmail.com>
Subject: Re: [linux-next:master 13092/13104] error[E0609]: no field
 `group_leader` on type `bindings_raw::task_struct`
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 3:34 AM kernel test robot <yujie.liu@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   9250d2f72dc46a808b6aa23bf50dd670f1f52ddc
> commit: 475dd867241716f1b6ab12cc188c221bfadacc40 [13092/13104] Merge branch 'rust-next' of https://github.com/Rust-for-Linux/linux.git
> config: arm64-randconfig-r033-20220728 (attached as .config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install arm64 cross compiling tool for clang build
>          # apt-get install binutils-aarch64-linux-gnu
>          # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=475dd867241716f1b6ab12cc188c221bfadacc40
>          git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>          git fetch --no-tags linux-next master
>          git checkout 475dd867241716f1b6ab12cc188c221bfadacc40
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <yujie.liu@intel.com>

Fixed in rust-next (and v8 of the Rust patch series):
https://github.com/Rust-for-Linux/linux/pull/850

Thanks!

Cheers,
Miguel
