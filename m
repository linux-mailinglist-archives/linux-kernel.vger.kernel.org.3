Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C55AA019
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiIATem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiIATei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:34:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E89753F;
        Thu,  1 Sep 2022 12:34:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c2so18005815plo.3;
        Thu, 01 Sep 2022 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=Xwk/X3XW/n8YVg10+aCzfkjIQYvdcIXQ5VXDewTVwHQ=;
        b=c58/kXmzIIZucQb3ENiqDvcphxG2PJaMDsOGd2Lqw6QNfnSmV3US1cYcGXS4PiLtfv
         YxA24wdEV8RM/f3c2QKeSquJyuJPDlX/RplVfCwJUnKcJO6GVNeRZ8bezoYwhiU0tYjE
         T2WESPXDF8k4LCP4G1VuD9uuo0z5vv1esjsToQGTWsheAMIbcO+Q6xhFQIe2ElhiqI77
         tXJnxtKT3qHSIkDehhGDoWCJyPh0fzz40Kk3i1hRYI2zk36GYW2FAJq2kh+JSXBPVK4P
         EA00yc3cC/imt3U3cRoBPdglrpBtz6afTWd5wz0PcIVb6hMwqYXvHlo62lQrSyeWTmfZ
         Etkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=Xwk/X3XW/n8YVg10+aCzfkjIQYvdcIXQ5VXDewTVwHQ=;
        b=rdAlV/LGw5Q/9JVMK3f1EuI2KI2vzC7lsJPIciN5NlixH+wY1LYvxx3zvJ+8YbUsyR
         41OpsmcJ1XMkKgQ4Lof9gL0Dl3dwLUWAUSW9IJqhMXOQ0ZkbtEdOBwAMCdx/wBJ1GM4C
         dt865zVOBmAW2/m8IiPLfV+wN00cRzZc52y2UnMTaLBMk+/iBEA10Mfpi29ZtvduTyA4
         kJnk+lZq1SpgKfl9GmOLsayFmxB607BOlJHWYu8OymYST9hMtFpaJ5G238qQH2S0StbF
         zRGrhbxaeso8HozwxL432VF2KguuFCVIcaqnEf9PaeUT5OxBvgDVY3RgnGEYoA6jh4Py
         qhxA==
X-Gm-Message-State: ACgBeo3OEOVp80Wie5OCaCxMh6kPXkteqVwdKO+7iZlr6aJ/O90rR5/V
        b6kV6pYwmaTNt8g/TNb2WSc=
X-Google-Smtp-Source: AA6agR64X33w5QtJo7wem7QV9n1gdbO4iz/918AvOtTCwgg0yJM3MTD6Vw+UzgrY0W45kUrb8vaKLQ==
X-Received: by 2002:a17:902:db12:b0:172:9e51:64 with SMTP id m18-20020a170902db1200b001729e510064mr32074827plx.140.1662060876643;
        Thu, 01 Sep 2022 12:34:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id on4-20020a17090b1d0400b001fda71ab2aesm3748136pjb.11.2022.09.01.12.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 12:34:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ba161718-bc61-57b8-dfbe-dee666fd06e8@roeck-us.net>
Date:   Thu, 1 Sep 2022 12:34:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] string: Introduce strtomem() and strtomem_pad()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220901190952.2229696-1-keescook@chromium.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220901190952.2229696-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 12:09, Kees Cook wrote:
> One of the "legitimate" uses of strncpy() is copying a NUL-terminated
> string into a fixed-size non-NUL-terminated character array. To avoid
> the weaknesses and ambiguity of intent when using strncpy(), provide
> replacement functions that explicitly distinguish between trailing
> padding and not, and require the destination buffer size be discoverable
> by the compiler.
> 
> For example:
> 
> struct obj {
> 	int foo;
> 	char small[4] __nonstring;
> 	char big[8] __nonstring;
> 	int bar;
> };
> 
> struct obj p;
> 
> /* This will truncate to 4 chars with no trailing NUL */
> strncpy(p.small, "hello", sizeof(p.small));
> /* p.small contains 'h', 'e', 'l', 'l' */
> 
> /* This will NUL pad to 8 chars. */
> strncpy(p.big, "hello", sizeof(p.big));
> /* p.big contains 'h', 'e', 'l', 'l', 'o', '\0', '\0', '\0' */
> 
> When the "__nonstring" attributes are missing, the intent of the
> programmer becomes ambiguous for whether the lack of a trailing NUL
> in the p.small copy is a bug. Additionally, it's not clear whether
> the trailing padding in the p.big copy is _needed_. Both cases
> become unambiguous with:
> 
> strtomem(p.small, "hello");
> strtomem_pad(p.big, "hello", 0);
> 
> See also https://github.com/KSPP/linux/issues/90
> 
> Expand the memcpy KUnit tests to include these functions.
> 
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
>   - updated deprecated.rst to include strtomem*()
>   - added kerndoc and replacement table to strncpy()
>   - switched to ULONG_MAX in KUnit tests (Geert)
>   - fix typo in commit log example (Geert)
> v1: https://lore.kernel.org/lkml/20220831230006.1016236-1-keescook@chromium.org
> ---
>   Documentation/process/deprecated.rst | 11 +++---
>   include/linux/fortify-string.h       | 30 ++++++++++++++++
>   include/linux/string.h               | 43 ++++++++++++++++++++++
>   lib/memcpy_kunit.c                   | 53 ++++++++++++++++++++++++++++
>   4 files changed, 133 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index a6e36d9c3d14..783b0488cf4d 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -138,17 +138,20 @@ be NUL terminated. This can lead to various linear read overflows and
>   other misbehavior due to the missing termination. It also NUL-pads
>   the destination buffer if the source contents are shorter than the
>   destination buffer size, which may be a needless performance penalty
> -for callers using only NUL-terminated strings. The safe replacement is
> +for callers using only NUL-terminated strings.
> +
> +When the destination is required to be NUL-terminated, the replacement is
>   strscpy(), though care must be given to any cases where the return value
>   of strncpy() was used, since strscpy() does not return a pointer to the
>   destination, but rather a count of non-NUL bytes copied (or negative
>   errno when it truncates). Any cases still needing NUL-padding should
>   instead use strscpy_pad().
>   
> -If a caller is using non-NUL-terminated strings, strncpy() can
> -still be used, but destinations should be marked with the `__nonstring
> +If a caller is using non-NUL-terminated strings, strtomem() should be
> +be used, and the destinations should be marked with the `__nonstring

s/be //

>   <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
> -attribute to avoid future compiler warnings.
> +attribute to avoid future compiler warnings. For cases still needing
> +NUL-padding, strtomem_pad() can be used.
>   
>   strlcpy()
>   ---------
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 3b401fa0f374..eed2119b23c5 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -77,6 +77,36 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
>   #define POS	__pass_object_size(1)
>   #define POS0	__pass_object_size(0)
>   
> +/** strncpy - Copy a string to memory with non-guaranteed NUL padding

Does that need a newline before strncpy() ?

> + *
> + * @p: pointer to destination of copy
> + * @q: pointer to NUL-terminated source string to copy
> + * @size: bytes to write at @p
> + *
> + * If strlen(@q) >= @size, the copy of @q will stop after @size bytes,
> + * and @p will NOT be NUL-terminated
> + *
> + * If strlen(@q) < @size, following the copy of @q, trailing NUL bytes
> + * will be written to @p until @size total bytes have been written.
> + *
> + * Do not use this function. While FORTIFY_SOURCE tries to avoid
> + * over-reads of @q, it cannot defend against writing unterminated
> + * results to @p. Using strncpy() remains ambiguous and fragile.
> + * Instead, please choose an alternative, so that the expectation
> + * of @p's contents is unambiguous:
> + *
> + * @p needs to be:     | padded to @size | not padded
> + * --------------------+-----------------+------------+
> + *      NUL-terminated | strscpy_pad()   | strscpy()  |
> + * --------------------+-----------------+------------+
> + *  not NUL-terminated | strtomem_pad()  | strtomem() |
> + * --------------------+-----------------+------------+
> + *
> + * Note strscpy*()'s differing return values for detecting truncation,
> + * and strtomem*()'s expectation that the destination is marked with
> + * __nonstring when it is a character array.
> + *
> + */
>   __FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
>   char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
>   {
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 61ec7e4f6311..cf7607b32102 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -260,6 +260,49 @@ static inline const char *kbasename(const char *path)
>   void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>   		    int pad);
>   
> +/**
> + * strtomem_pad - Copy NUL-terminated string to non-NUL-terminated buffer
> + *
> + * @dest: Pointer of destination character array (marked as __nonstring)
> + * @src: Pointer to NUL-terminated string
> + * @pad: Padding character to fill any remaining bytes of @dest after copy
> + *
> + * This is a replacement for strncpy() uses where the destination is not
> + * a NUL-terminated string, but with bounds checking on the source size, and
> + * an explicit padding character. If padding is not required, use strtomem().
> + *
> + * Note that the size of @dest is not an argument, as the length of @dest
> + * must be discoverable by the compiler.
> + */
> +#define strtomem_pad(dest, src, pad)	do {				\
> +	const size_t _dest_len = __builtin_object_size(dest, 1);	\
> +									\
> +	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
> +		     _dest_len == (size_t)-1);				\
> +	memcpy_and_pad(dest, _dest_len, src, strnlen(src, _dest_len), pad); \
> +} while (0)
> +
> +/**
> + * strtomem - Copy NUL-terminated string to non-NUL-terminated buffer
> + *
> + * @dest: Pointer of destination character array (marked as __nonstring)
> + * @src: Pointer to NUL-terminated string
> + *
> + * This is a replacement for strncpy() uses where the destination is not
> + * a NUL-terminated string, but with bounds checking on the source size, and
> + * without trailing padding. If padding is required, use strtomem_pad().
> + *
> + * Note that the size of @dest is not an argument, as the length of @dest
> + * must be discoverable by the compiler.
> + */
> +#define strtomem(dest, src)	do {					\
> +	const size_t _dest_len = __builtin_object_size(dest, 1);	\
> +									\
> +	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
> +		     _dest_len == (size_t)-1);				\
> +	memcpy(dest, src, min(_dest_len, strnlen(src, _dest_len)));	\
> +} while (0)
> +
>   /**
>    * memset_after - Set a value after a struct member to the end of a struct
>    *
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 62f8ffcbbaa3..598f5f7dadf4 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -272,10 +272,63 @@ static void memset_test(struct kunit *test)
>   #undef TEST_OP
>   }
>   
> +static void strtomem_test(struct kunit *test)
> +{
> +	static const char input[] = "hi";
> +	static const char truncate[] = "this is too long";
> +	struct {
> +		unsigned long canary1;
> +		unsigned char output[sizeof(unsigned long)] __nonstring;
> +		unsigned long canary2;
> +	} wrap;
> +
> +	memset(&wrap, 0xFF, sizeof(wrap));
> +	KUNIT_EXPECT_EQ_MSG(test, wrap.canary1, ULONG_MAX,
> +			    "bad initial canary value");
> +	KUNIT_EXPECT_EQ_MSG(test, wrap.canary2, ULONG_MAX,
> +			    "bad initial canary value");
> +
> +	/* Check unpadded copy leaves surroundings untouched. */
> +	strtomem(wrap.output, input);
> +	KUNIT_EXPECT_EQ(test, wrap.canary1, ULONG_MAX);
> +	KUNIT_EXPECT_EQ(test, wrap.output[0], input[0]);
> +	KUNIT_EXPECT_EQ(test, wrap.output[1], input[1]);
> +	for (int i = 2; i < sizeof(wrap.output); i++)
> +		KUNIT_EXPECT_EQ(test, wrap.output[i], 0xFF);
> +	KUNIT_EXPECT_EQ(test, wrap.canary2, ULONG_MAX);
> +
> +	/* Check truncated copy leaves surroundings untouched. */
> +	memset(&wrap, 0xFF, sizeof(wrap));
> +	strtomem(wrap.output, truncate);
> +	KUNIT_EXPECT_EQ(test, wrap.canary1, ULONG_MAX);
> +	for (int i = 0; i < sizeof(wrap.output); i++)
> +		KUNIT_EXPECT_EQ(test, wrap.output[i], truncate[i]);
> +	KUNIT_EXPECT_EQ(test, wrap.canary2, ULONG_MAX);
> +
> +	/* Check padded copy leaves only string padded. */
> +	memset(&wrap, 0xFF, sizeof(wrap));
> +	strtomem_pad(wrap.output, input, 0xAA);
> +	KUNIT_EXPECT_EQ(test, wrap.canary1, ULONG_MAX);
> +	KUNIT_EXPECT_EQ(test, wrap.output[0], input[0]);
> +	KUNIT_EXPECT_EQ(test, wrap.output[1], input[1]);
> +	for (int i = 2; i < sizeof(wrap.output); i++)
> +		KUNIT_EXPECT_EQ(test, wrap.output[i], 0xAA);
> +	KUNIT_EXPECT_EQ(test, wrap.canary2, ULONG_MAX);
> +
> +	/* Check truncated padded copy has no padding. */
> +	memset(&wrap, 0xFF, sizeof(wrap));
> +	strtomem(wrap.output, truncate);
> +	KUNIT_EXPECT_EQ(test, wrap.canary1, ULONG_MAX);
> +	for (int i = 0; i < sizeof(wrap.output); i++)
> +		KUNIT_EXPECT_EQ(test, wrap.output[i], truncate[i]);
> +	KUNIT_EXPECT_EQ(test, wrap.canary2, ULONG_MAX);
> +}
> +
>   static struct kunit_case memcpy_test_cases[] = {
>   	KUNIT_CASE(memset_test),
>   	KUNIT_CASE(memcpy_test),
>   	KUNIT_CASE(memmove_test),
> +	KUNIT_CASE(strtomem_test),
>   	{}
>   };
>   

