Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD86483BD8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiADGRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:17:47 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:34360 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiADGRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:17:46 -0500
Received: by mail-ed1-f43.google.com with SMTP id u25so22959951edf.1;
        Mon, 03 Jan 2022 22:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pHkaFCQ7pu2TR8eztQX9gVwPPOBVlFAaACaZ0iSfECg=;
        b=IRZ8c3oLhc/wSFGxAb5y7K+hBK68R3umxspE/XjqNywzsKw6PYFqJfexRXvwxYfhwA
         /nuR1eiSt3GRqjFDGWHy4Irf+9lGgLZqiY/5ChE6Ap0PjhLB0J9VFjkbCpRgwrLW9pIf
         zCKHW9rRD8Nw6MWuiermX80bi7UqfjzPJRomE462TudoUUBScCaY/oq1F2PrIDbN6PkO
         VVvI9cwnKHDKN+G+w3eI7PV4Bw/aNL2l1nfDwlwajESmMU98OAqszQaj4R/G6xRPeBii
         UfEiX25dqvNYaDmzUGGbo02Tli2qPL6ZLlnDKJwN2f2DbZOwKtIZY4/THqieCak2d5f8
         ucaA==
X-Gm-Message-State: AOAM530NxyjFW4OlHCOJOHNxqrm0tMin+L+zd6Jgi+gHUv76kj8lF0xO
        Ok27hEsiM6sInyTykewSUUo=
X-Google-Smtp-Source: ABdhPJwLdBXMrng9HGpEUbQe43EeRAgi7WoS98rK5bcmSkZR5943V2fvIkVKOdDmAmvXm7SLu7RjIQ==
X-Received: by 2002:a17:906:dc94:: with SMTP id cs20mr37131508ejc.316.1641277065191;
        Mon, 03 Jan 2022 22:17:45 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id i20sm14319867edv.44.2022.01.03.22.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 22:17:44 -0800 (PST)
Message-ID: <44a258b0-048d-9e32-1583-ae52aaee0a1a@kernel.org>
Date:   Tue, 4 Jan 2022 07:17:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [was: libtraceevent: Increase libtraceevent logging when verbose]
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        eranian@google.com
References: <20210923001024.550263-1-irogers@google.com>
 <20210923001024.550263-4-irogers@google.com>
 <bc2b0786-8965-1bcd-2316-9d9bb37b9c31@kernel.org>
 <c19ca2a2-54c9-88b1-b705-5a2cd4dd9580@kernel.org>
 <YdMTIl7jn25XrUn8@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YdMTIl7jn25XrUn8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 01. 22, 16:15, Arnaldo Carvalho de Melo wrote:
> Tried reproducing here on fedora 34 but it is at 1.1.1:

FWIW, it's openSUSE Tumbleweed:
$ rpm -q libtraceevent1
libtraceevent1-1.3.0-1.3.x86_64

thanks,
-- 
js
suse labs
