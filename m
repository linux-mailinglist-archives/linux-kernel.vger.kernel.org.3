Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34E749C447
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiAZH0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:26:52 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:44583 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiAZH0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:26:51 -0500
Received: by mail-wr1-f45.google.com with SMTP id k18so24062430wrg.11;
        Tue, 25 Jan 2022 23:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CZax7EQBH563HldfPw1gEZv2Sp2IgoganEI/8KNBbfs=;
        b=t7sNo8N787JSubt/FJhY5ivkYga3f35ABKhgrdO65CvjkDf6YBD6aiwBNfKDcMssZg
         6sSZKETuvnCsQesSrZ+GZHSMY6ohbuIQRmkcjVn6pGy2ZxvclYOU3NlNWY3C2XhvYbhi
         Fhm/rMrxSOX/tf/+l8GuNesaXvogS1p0YKy1OfNJ4CLabQ/iuMRNrzFtfOk30bGf8I1W
         eKqvt1bCH9f6W39tR9oq+kogDTaOM7uK9Y53qCaP5fOcNukYMcP8O3p4cMXjjvR6IgQd
         6oWWa5QPQF/Ab0qPTi3Tfuti9+uSr+WXloJqBddDgUZSKE7W7esG4d0fRymbseph3uyR
         u8xQ==
X-Gm-Message-State: AOAM532fMfIO37+iUsGWZ7lK7USQjmMQYv1FkIHIi4HxBkdfLIenTf8r
        IDaisoAQ7wEcjydVlzGxUiQ=
X-Google-Smtp-Source: ABdhPJyN+67ieJMrSsIClF7loH036Apb2svtS1Fdvh3BrhY/xXejyWDOCKFxPVtZKYv7C/sBNAgggw==
X-Received: by 2002:a5d:6210:: with SMTP id y16mr20108520wru.454.1643182009984;
        Tue, 25 Jan 2022 23:26:49 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id c14sm590148wri.56.2022.01.25.23.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 23:26:49 -0800 (PST)
Message-ID: <bf35dee8-4f0c-a91e-de89-0c39c749a650@kernel.org>
Date:   Wed, 26 Jan 2022 08:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 10/11] serial: make uart_console_write->putchar()'s
 character a char
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan@kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>
References: <20220124071430.14907-11-jslaby@suse.cz>
 <202201242255.WTSwb6EN-lkp@intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <202201242255.WTSwb6EN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 01. 22, 15:30, kernel test robot wrote:
> Hi Jiri,
> 
> I love your patch! Yet something to improve:

Please skip this patch. I wonder why the bot didn't catch it in my queue 
already.

> [auto build test ERROR on tty/tty-testing]
> [also build test ERROR on v5.17-rc1 next-20220124]
> [cannot apply to shawnguo/for-next davem-sparc/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Jiri-Slaby/TTY-patches-for-5-18/20220124-151758
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> config: microblaze-randconfig-r006-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242255.WTSwb6EN-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/45520d4f6db241db0b77f41162adba4a9977956c
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Jiri-Slaby/TTY-patches-for-5-18/20220124-151758
>          git checkout 45520d4f6db241db0b77f41162adba4a9977956c
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/tty/serial/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/tty/serial/sprd_serial.c: In function 'sprd_console_write':
>>> drivers/tty/serial/sprd_serial.c:1007:44: error: passing argument 4 of 'uart_console_write' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      1007 |         uart_console_write(port, s, count, sprd_console_putchar);
>           |                                            ^~~~~~~~~~~~~~~~~~~~
>           |                                            |
>           |                                            void (*)(struct uart_port *, int)
>     In file included from drivers/tty/serial/sprd_serial.c:18:
>     include/linux/serial_core.h:402:32: note: expected 'void (*)(struct uart_port *, char)' but argument is of type 'void (*)(struct uart_port *, int)'
>       402 |                         void (*putchar)(struct uart_port *, char));
>           |                         ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
> 
> 
> vim +/uart_console_write +1007 drivers/tty/serial/sprd_serial.c
> 
> b7396a38fb28db Chunyan Zhang 2015-01-28   992
> b7396a38fb28db Chunyan Zhang 2015-01-28   993  static void sprd_console_write(struct console *co, const char *s,
> b7396a38fb28db Chunyan Zhang 2015-01-28   994  			       unsigned int count)
> b7396a38fb28db Chunyan Zhang 2015-01-28   995  {
> b7396a38fb28db Chunyan Zhang 2015-01-28   996  	struct uart_port *port = &sprd_port[co->index]->port;
> b7396a38fb28db Chunyan Zhang 2015-01-28   997  	int locked = 1;
> b7396a38fb28db Chunyan Zhang 2015-01-28   998  	unsigned long flags;
> b7396a38fb28db Chunyan Zhang 2015-01-28   999
> b7396a38fb28db Chunyan Zhang 2015-01-28  1000  	if (port->sysrq)
> b7396a38fb28db Chunyan Zhang 2015-01-28  1001  		locked = 0;
> b7396a38fb28db Chunyan Zhang 2015-01-28  1002  	else if (oops_in_progress)
> b7396a38fb28db Chunyan Zhang 2015-01-28  1003  		locked = spin_trylock_irqsave(&port->lock, flags);
> b7396a38fb28db Chunyan Zhang 2015-01-28  1004  	else
> b7396a38fb28db Chunyan Zhang 2015-01-28  1005  		spin_lock_irqsave(&port->lock, flags);
> b7396a38fb28db Chunyan Zhang 2015-01-28  1006
> b7396a38fb28db Chunyan Zhang 2015-01-28 @1007  	uart_console_write(port, s, count, sprd_console_putchar);
> b7396a38fb28db Chunyan Zhang 2015-01-28  1008
> b7396a38fb28db Chunyan Zhang 2015-01-28  1009  	/* wait for transmitter to become empty */
> b7396a38fb28db Chunyan Zhang 2015-01-28  1010  	wait_for_xmitr(port);
> b7396a38fb28db Chunyan Zhang 2015-01-28  1011
> b7396a38fb28db Chunyan Zhang 2015-01-28  1012  	if (locked)
> b7396a38fb28db Chunyan Zhang 2015-01-28  1013  		spin_unlock_irqrestore(&port->lock, flags);
> b7396a38fb28db Chunyan Zhang 2015-01-28  1014  }
> b7396a38fb28db Chunyan Zhang 2015-01-28  1015
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


-- 
js
suse labs
