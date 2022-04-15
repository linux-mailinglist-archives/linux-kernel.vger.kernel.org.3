Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D620D502F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349078AbiDOTum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbiDOTuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:50:40 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD1B60D83
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:48:09 -0700 (PDT)
Date:   Fri, 15 Apr 2022 19:47:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1650052086;
        bh=0dHyPpYFL4d5gBo5vU+rHTsqfQyBgNZ3Va/9kH88g+U=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=qwOyU6CLwcBqfB7Q596OFs3j+gd2VKQU6+OX2LUFAIINL6JZEAb6UhcdbitQ6xYj2
         rnF5Jbtnyo+pU+Ln2DUPYCwb0A280j0SzpSOgv1Dp3uOfOGlU94f7DPx695Sz7kM/U
         uiXLi40XDe7jUSCPjGeZk6qSK9BfIQ6LComJNjbOpFZ5SZvr7Fn6isbt8W0C68yeAA
         ZuiErSDRTDjwQZJ6qOgyHU2rok6MOjG63osKnfoq7IJ5LgEV2hp2vuNqgk1VJEStul
         w1xnIaMEAMAODtwu+L8jsmZf51ofb5PnWxZdeRIi5je9HQFXCXTeS3blulV3zcE4TA
         YobJ/XfeFFntA==
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v8] platform: x86: Add ChromeOS ACPI device driver
Message-ID: <eygNMwL4gadqjJuOq-syanavJ5sAb5_dHTcQ0V9TU5kM5uh5TZUQXdYsNFTtnSm1ZI5WKhw7BgzG8lXEwJKEZz4agWq5_HkFDGWiFuuo7fE=@protonmail.com>
In-Reply-To: <Ylmmf03fewXEjRr0@debian-BULLSEYE-live-builder-AMD64>
References: <Ylmmf03fewXEjRr0@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2022. =C3=A1prilis 15., p=C3=A9ntek 19:08 keltez=C3=A9ssel, Muhammad Usama =
Anjum <usama.anjum@collabora.com> =C3=ADrta

> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> The x86 Chromebooks have ChromeOS ACPI device. This driver attaches to
> the ChromeOS ACPI device and exports the values reported by ACPI in a
> sysfs directory. This data isn't present in ACPI tables when read
> through ACPI tools, hence a driver is needed to do it. The driver gets
> data from firmware using ACPI component of the kernel. The ACPI values
> are presented in string form (numbers as decimal values) or binary
> blobs, and can be accessed as the contents of the appropriate read only
> files in the standard ACPI device's sysfs directory tree. This data is
> consumed by the ChromeOS user space.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v8:
> - Change struct platform_driver name from chromeos_acpi_driver to
>   chromeos_acpi_device_driver
>
> Changes in v7:
> - Rename acpi_chromeos Kconfig option to chromeos_acpi
> - Change this acpi driver to platform driver
> - Minor cosmetic changes
>
> There were the following concerns on v4 which have been delt with in
> v5/v6:
> - Remove BINF.{0,1,4} from sysfs as they are reserved and not used
>   anymore
> - Reword the description of MECK
> - Change function name from chromeos_acpi_alloc_name() to
>   chromeos_acpi_gen_file_name()
> - Remove local variable obj in chromeos_acpi_add_method()
> - Replace usage of dev_info() to dev_dbg()
> - Improve the description of the patch
> - Add the firmware interface document which serves as primary
>   documentation and garantees that this interface will not change
> - GGL0001 is valid PNP ID of the Google. PNP ID can be used with the
>   ACPI devices. Consensus was developed on it in discussion of v4.
>
> Changes in v6:
> - Correct authorship and path email's From
> - Add changelog between v4 and v5 in detail
> - Add copywrite year 2022
> - Improve the description and add concerns from V4 which have been fixed
>
> Changes in v5:
> - Improve the description of the patch
> - Document firmware interface
> - Update sysfs interface documentation
> - Remove binf{0,1,4} as they have been deprecated
> - Update some cleanup logic in case of error
>   - Remove freeing of chromeos_acpi.root explicitely in
>     chromeos_acpi_device_remove() as it'll be automatically freed by
>     chromeos_acpi_remove_groups()
>   - If sysfs_create_groups() fails in chromeos_acpi_process_mlst(),
>     cleanup all groups
> - Cosmetic changes
>
> Changes in v4:
> https://lore.kernel.org/lkml/20200413134611.478441-1-enric.balletbo@colla=
bora.com/t/
> - Add COMPILE_TEST to increase build coverage.
> - Add sysfs ABI documentation.
> - Rebased on top of 5.7-rc1 and solve conflicts.
> - Cc ACPI maintainers.
>
> Changes in v3:
> - Use attribute groups instead of adding files "by hand".
> - Do not use "raw" kobject to create directories.
> - Do not abuse of the platform_device interface. Remove it.
>
> Changes in v2:
> - Note that this version is a total rework, with those major changes:
> - Use lists to track dinamically allocated attributes and groups.
> - Use sysfs binary attributes to store the ACPI contents.
> - Remove all the functionalities except the one that creates the sysfs fi=
les.
> ---
>  .../ABI/testing/sysfs-driver-chromeos-acpi    | 126 +++++
>  .../acpi/chromeos-acpi-device.rst             | 363 +++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |   1 +
>  drivers/platform/x86/Kconfig                  |  11 +
>  drivers/platform/x86/Makefile                 |   3 +
>  drivers/platform/x86/chromeos_acpi.c          | 513 ++++++++++++++++++
>  6 files changed, 1017 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-chromeos-acpi
>  create mode 100644 Documentation/firmware-guide/acpi/chromeos-acpi-devic=
e.rst
>  create mode 100644 drivers/platform/x86/chromeos_acpi.c
>
> [...]
> diff --git a/drivers/platform/x86/chromeos_acpi.c b/drivers/platform/x86/=
chromeos_acpi.c
> new file mode 100644
> index 0000000000000..de86119a446b8
> --- /dev/null
> +++ b/drivers/platform/x86/chromeos_acpi.c
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChromeOS specific ACPI extensions
> + *
> + * Copyright 2011 Google, Inc.
> + * Copyright 2020-2022 Google LLC
> + *
> + * This file is a rework and part of the code is ported from chromeos-3.=
18
> + * kernel and was originally written by Vadim Bendebury <vbendeb@chromiu=
m.org>.
> + *
> + * This driver attaches to the ChromeOS ACPI device and then exports the
> + * values reported by the ACPI in a sysfs directory. All values are
> + * presented in the string form (numbers as decimal values) and can be
> + * accessed as the contents of the appropriate read only files in the
> + * sysfs directory tree.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +
> +/*
> + * ACPI method name for MLST; the response for this method is a package =
of
> + * strings listing the methods which should be reflected in sysfs.
> + */
> +#define MLST "MLST"
> +
> +/*
> + * The default list of methods the ChromeOS ACPI device is supposed to e=
xport,
> + * if the MLST method is not present or is poorly formed.  The MLST meth=
od
> + * itself is included, to aid in debugging.
> + */
> +static char *chromeos_acpi_default_methods[] =3D {
> +=09"CHSW", "HWID", "BINF", "GPIO", "CHNV", "FWID", "FRID", MLST
> +};
> +
> +/*
> + * Representation of a single sysfs attribute. In addition to the standa=
rd
> + * bin_attribute structure has a list of these structures (to keep track=
 for
> + * de-allocation when removing the driver) and a pointer to the actual
> + * attribute name and value, reported when accessing the appropriate sys=
fs
> + * file.
> + */
> +struct chromeos_acpi_attribute {
> +=09struct bin_attribute bin_attr;
> +=09struct list_head list;
> +=09char *name;
> +=09char *data;
> +};
> +
> +/*
> + * Representation of a sysfs attribute group (a sub directory in the dev=
ice's
> + * sysfs directory). In addition to the standard structure has lists to =
allow
> + * to keep track of the allocated structures.
> + */
> +struct chromeos_acpi_attribute_group {
> +=09struct attribute_group group;
> +=09struct list_head attribs;
> +=09struct list_head list;
> +=09char *name;
> +};
> +
> +/*
> + * This is the main structure, we use it to store data and adds links po=
inting
> + * at lists of allocated attributes and attribute groups.
> + */
> +struct chromeos_acpi_dev {
> +=09struct chromeos_acpi_attribute_group *root;
> +=09const struct attribute_group **dev_groups;
> +=09struct list_head groups;
> +=09unsigned int num_groups;
> +=09unsigned int num_attrs;
> +};
> +
> +static struct chromeos_acpi_dev chromeos_acpi;
> +
> +static ssize_t chromeos_acpi_read_bin_attribute(struct file *filp,
> +=09=09=09=09=09=09struct kobject *kobj,
> +=09=09=09=09=09=09struct bin_attribute *bin_attr,
> +=09=09=09=09=09=09char *buffer, loff_t pos,
> +=09=09=09=09=09=09size_t count)
> +{
> +=09struct chromeos_acpi_attribute *info =3D bin_attr->private;
> +
> +=09return memory_read_from_buffer(buffer, count, &pos, info->data,
> +=09=09=09=09       info->bin_attr.size);
> +}
> +
> +static char *chromeos_acpi_gen_file_name(char *name, int count, int inde=
x)
> +{
> +=09char *str;
> +
> +=09if (count =3D=3D 1)
> +=09=09str =3D kstrdup(name, GFP_KERNEL);
> +=09else
> +=09=09str =3D kasprintf(GFP_KERNEL, "%s.%d", name, index);
> +
> +=09return str;
> +}
> +
> +static int
> +chromeos_acpi_add_attr(struct chromeos_acpi_attribute_group *aag,
> +=09=09       union acpi_object *element, char *name,
> +=09=09       int count, int index)
> +{
> +=09struct chromeos_acpi_attribute *info;
> +=09char buffer[24]; /* enough to store a u64 and null character */
> +=09int length;
> +=09int ret;
> +
> +=09/* Files BINF.{0,1,4} are historical and no longer used. */
> +=09if (!strcmp(name, "BINF") && (index =3D=3D 0 || index =3D=3D 1 || ind=
ex =3D=3D 4))
> +=09=09return 0;
> +
> +=09info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> +=09if (!info)
> +=09=09return -ENOMEM;
> +
> +=09info->name =3D chromeos_acpi_gen_file_name(name, count, index);
> +=09if (!info->name) {
> +=09=09ret =3D -ENOMEM;
> +=09=09goto free_attribute;
> +=09}
> +=09sysfs_bin_attr_init(&info->bin_attr);
> +=09info->bin_attr.attr.name =3D info->name;
> +=09info->bin_attr.attr.mode =3D 0444;
> +
> +=09switch (element->type) {
> +=09case ACPI_TYPE_BUFFER:
> +=09=09length =3D element->buffer.length;
> +=09=09info->data =3D kmemdup(element->buffer.pointer,
> +=09=09=09=09     length, GFP_KERNEL);
> +=09=09break;
> +=09case ACPI_TYPE_INTEGER:
> +=09=09length =3D snprintf(buffer, sizeof(buffer), "%d",
> +=09=09=09=09  (int)element->integer.value);
> +=09=09info->data =3D kmemdup(buffer, length, GFP_KERNEL);

You can use `kasprintf()` here, no?


> +=09=09break;
> +=09case ACPI_TYPE_STRING:
> +=09=09length =3D element->string.length + 1;
> +=09=09info->data =3D kstrdup(element->string.pointer, GFP_KERNEL);
> +=09=09break;
> +=09default:
> +=09=09ret =3D -EINVAL;
> +=09=09goto free_attr_name;
> +=09}
> +
> +=09if (!info->data) {
> +=09=09ret =3D -ENOMEM;
> +=09=09goto free_attr_name;
> +=09}
> +
> +=09info->bin_attr.size =3D length;
> +=09info->bin_attr.read =3D chromeos_acpi_read_bin_attribute;
> +=09info->bin_attr.private =3D info;
> +
> +=09INIT_LIST_HEAD(&info->list);

(technically you only need to initialize the list head explicitly, so this =
is not
 strictly needed; there are other examples of such `INIT_LIST_HEAD()` calls
 in the code)


> +
> +=09list_add(&info->list, &aag->attribs);
> +=09return 0;
> +
> +free_attr_name:
> +=09kfree(info->name);
> +free_attribute:
> +=09kfree(info);
> +=09return ret;
> +}
> +
> +static void
> +chromeos_acpi_remove_attribs(struct chromeos_acpi_attribute_group *aag)
> +{
> +=09struct chromeos_acpi_attribute *attr, *tmp_attr;
> +
> +=09list_for_each_entry_safe(attr, tmp_attr, &aag->attribs, list) {
> +=09=09kfree(attr->name);
> +=09=09kfree(attr->data);
> +=09=09kfree(attr);
> +=09}
> +}
> +
> +static int
> +chromeos_acpi_add_attribs_to_group(struct chromeos_acpi_attribute_group =
*aag,
> +=09=09=09=09   unsigned int num_attrs)
> +{
> +=09struct chromeos_acpi_attribute *attr;
> +=09int count =3D 0;
> +
> +=09aag->group.bin_attrs =3D kcalloc(num_attrs + 1,
> +=09=09=09=09       sizeof(*aag->group.bin_attrs),
> +=09=09=09=09       GFP_KERNEL);
> +=09if (!aag->group.bin_attrs)
> +=09=09return -ENOMEM;
> +
> +=09list_for_each_entry(attr, &aag->attribs, list) {
> +=09=09aag->group.bin_attrs[count] =3D &attr->bin_attr;
> +=09=09count++;
> +=09}
> +
> +=09chromeos_acpi.num_groups++;
> +=09list_add(&aag->list, &chromeos_acpi.groups);
> +
> +=09return 0;
> +}
> +
> +/**
> + * chromeos_acpi_add_group() - Create a sysfs group including attributes
> + *=09=09=09       representing a nested ACPI package
> + *
> + * @obj: Package contents as returned by ACPI
> + * @name: Name of the group
> + * @num_attrs: Number of attributes of this package
> + * @index: Index number of this particular group
> + *
> + * The created group is called @name in case there is a single instance,=
 or
> + * @name.@index otherwise.
> + *
> + * All group and attribute storage allocations are included in the lists=
 for
> + * tracking of allocated memory.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int chromeos_acpi_add_group(union acpi_object *obj, char *name,
> +=09=09=09=09   int num_attrs, int index)
> +{
> +=09struct chromeos_acpi_attribute_group *aag;
> +=09union acpi_object *element;
> +=09int i, count, ret;
> +
> +=09aag =3D kzalloc(sizeof(*aag), GFP_KERNEL);
> +=09if (!aag)
> +=09=09return -ENOMEM;
> +=09aag->name =3D chromeos_acpi_gen_file_name(name, num_attrs, index);
> +=09if (!aag->name) {
> +=09=09ret =3D -ENOMEM;
> +=09=09goto free_group;
> +=09}
> +
> +=09INIT_LIST_HEAD(&aag->attribs);
> +=09INIT_LIST_HEAD(&aag->list);
> +
> +=09count =3D obj->package.count;
> +=09element =3D obj->package.elements;
> +=09for (i =3D 0; i < count; i++, element++) {
> +=09=09ret =3D chromeos_acpi_add_attr(aag, element, name, count, i);
> +=09=09if (ret)
> +=09=09=09goto free_group_attr;
> +=09}
> +
> +=09aag->group.name =3D aag->name;
> +
> +=09ret =3D chromeos_acpi_add_attribs_to_group(aag, count);
> +=09if (ret)
> +=09=09goto free_group_attr;
> +
> +=09return 0;
> +
> +free_group_attr:
> +=09chromeos_acpi_remove_attribs(aag);
> +=09kfree(aag->name);
> +free_group:
> +=09kfree(aag);
> +=09return ret;
> +}
> +
> +static void chromeos_acpi_remove_groups(void)
> +{
> +=09struct chromeos_acpi_attribute_group *aag, *tmp_aag;
> +
> +=09list_for_each_entry_safe(aag, tmp_aag, &chromeos_acpi.groups, list) {
> +=09=09chromeos_acpi_remove_attribs(aag);
> +=09=09kfree(aag->group.bin_attrs);
> +=09=09kfree(aag->name);
> +=09=09kfree(aag);
> +=09}
> +}
> +
> +/**
> + * chromeos_acpi_handle_package() - Create sysfs group including attribu=
tes
> + *=09=09=09=09    representing an ACPI package
> + *
> + * @pdev: Platform device
> + * @obj: Package contents as returned by ACPI
> + * @name: Name of the group
> + *
> + * Scalar objects included in the package get sysfs attributes created f=
or
> + * them. Nested packages are passed to a function creating a sysfs group=
 per
> + * package.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int chromeos_acpi_handle_package(struct platform_device *pdev,
> +=09=09=09=09=09union acpi_object *obj, char *name)
> +{
> +=09struct device *dev =3D &pdev->dev;
> +=09int count =3D obj->package.count;
> +=09union acpi_object *element;
> +=09int i, ret;
> +
> +=09element =3D obj->package.elements;
> +=09for (i =3D 0; i < count; i++, element++) {
> +=09=09if (element->type =3D=3D ACPI_TYPE_BUFFER ||
> +=09=09    element->type =3D=3D ACPI_TYPE_STRING ||
> +=09=09    element->type =3D=3D ACPI_TYPE_INTEGER) {
> +=09=09=09/* Create a single attribute in the root directory */
> +=09=09=09ret =3D chromeos_acpi_add_attr(chromeos_acpi.root,
> +=09=09=09=09=09=09     element, name,
> +=09=09=09=09=09=09     count, i);
> +=09=09=09if (ret) {
> +=09=09=09=09dev_err(dev, "error adding attributes (%d)\n",
> +=09=09=09=09=09ret);
> +=09=09=09=09return ret;
> +=09=09=09}
> +=09=09=09chromeos_acpi.num_attrs++;
> +=09=09} else if (element->type =3D=3D ACPI_TYPE_PACKAGE) {
> +=09=09=09/* Create a group of attributes */
> +=09=09=09ret =3D chromeos_acpi_add_group(element, name, count, i);
> +=09=09=09if (ret) {
> +=09=09=09=09dev_err(dev, "error adding a group (%d)\n",
> +=09=09=09=09=09ret);
> +=09=09=09=09return ret;
> +=09=09=09}
> +=09=09} else {
> +=09=09=09if (ret) {

`ret` can be potentially uninitialized here, no?


> +=09=09=09=09dev_err(dev, "error on element type (%d)\n",
> +=09=09=09=09=09ret);
> +=09=09=09=09return -EINVAL;
> +=09=09=09}
> +=09=09}
> +=09}
> +
> +=09return 0;
> +}
> +
> +/**
> + * chromeos_acpi_add_method() - Evaluate an ACPI method and create sysfs
> + *=09=09=09=09attributes
> + *
> + * @pdev: Platform device
> + * @name: Name of the method to evaluate
> + *
> + * Return: 0 on success, non-zero on failure
> + */
> +static int chromeos_acpi_add_method(struct platform_device *pdev, char *=
name)
> +{
> +=09struct device *dev =3D &pdev->dev;
> +=09struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09acpi_status status;
> +=09int ret =3D 0;
> +
> +=09status =3D acpi_evaluate_object(ACPI_COMPANION(&pdev->dev)->handle, n=
ame, NULL, &output);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09dev_err(dev, "failed to retrieve %s (%d)\n", name, status);

(maybe `acpi_format_exception(status)` would be more meaningful than the nu=
meric value)


> +=09=09return status;

This return value is potentially propagated to become the return value of
the probe function. The problem is that it is not a negative errno that the=
 probe
method should return but rather an ACPI status code.


> +=09}
> +
> +=09if (((union acpi_object *)output.pointer)->type =3D=3D ACPI_TYPE_PACK=
AGE)
> +=09=09ret =3D chromeos_acpi_handle_package(pdev, output.pointer, name);
> +
> +=09kfree(output.pointer);
> +=09return ret;
> +}
> +
> +/**
> + * chromeos_acpi_process_mlst() - Evaluate the MLST method and add metho=
ds
> + *=09=09=09=09  listed in the response
> + *
> + * @pdev: Platform device
> + *
> + * Returns: 0 if successful, non-zero if error.
> + */
> +static int chromeos_acpi_process_mlst(struct platform_device *pdev)
> +{
> +=09struct chromeos_acpi_attribute_group *aag;
> +=09char name[ACPI_NAMESEG_SIZE + 1];
> +=09union acpi_object *element, *obj;
> +=09struct device *dev =3D &pdev->dev;
> +=09struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09acpi_status status;
> +=09int ret =3D 0;
> +=09int size;
> +=09int i;
> +
> +=09status =3D acpi_evaluate_object(ACPI_COMPANION(&pdev->dev)->handle, M=
LST, NULL,
> +=09=09=09=09      &output);
> +=09if (ACPI_FAILURE(status))
> +=09=09return status;
> +
> +=09obj =3D output.pointer;
> +=09if (obj->type !=3D ACPI_TYPE_PACKAGE) {
> +=09=09ret =3D -EINVAL;
> +=09=09goto free_acpi_buffer;
> +=09}
> +
> +=09element =3D obj->package.elements;
> +=09for (i =3D 0; i < obj->package.count; i++, element++) {
> +=09=09if (element->type =3D=3D ACPI_TYPE_STRING) {
> +=09=09=09size =3D min(element->string.length + 1,
> +=09=09=09=09   (u32)ACPI_NAMESEG_SIZE + 1);

Is truncation a real possibility? Shouldn't it abort/etc. in that case?
And `min()` "returns" a u32 here but `size` is an `int`.


> +=09=09=09strscpy(name, element->string.pointer, size);
> +=09=09=09ret =3D chromeos_acpi_add_method(pdev, name);
> +=09=09=09if (ret) {
> +=09=09=09=09chromeos_acpi_remove_groups();
> +=09=09=09=09break;

Is just a `break` is enough here to handle the error? If this is not fatal,
then why is a `dev_warn()` not sufficient? If this is fatal, why continue
with the rest of the function?


> +=09=09=09}
> +=09=09}
> +=09}
> +
> +=09/* Add root attributes to the main group */
> +=09ret =3D chromeos_acpi_add_attribs_to_group(chromeos_acpi.root,
> +=09=09=09=09=09=09 chromeos_acpi.num_attrs);
> +=09if (ret)
> +=09=09goto free_acpi_buffer;
> +
> +=09chromeos_acpi.dev_groups =3D kcalloc(chromeos_acpi.num_groups + 1,
> +=09=09=09=09=09   sizeof(struct attribute_group),
> +=09=09=09=09=09   GFP_KERNEL);
> +
> +=09i =3D 0;
> +=09list_for_each_entry(aag, &chromeos_acpi.groups, list) {
> +=09=09chromeos_acpi.dev_groups[i] =3D &aag->group;
> +=09=09i++;
> +=09}
> +
> +=09ret =3D sysfs_create_groups(&dev->kobj, chromeos_acpi.dev_groups);
> +=09if (ret) {
> +=09=09kfree(chromeos_acpi.dev_groups);
> +
> +=09=09/* Remove allocated chromeos acpi groups and attributes */
> +=09=09chromeos_acpi_remove_groups();
> +=09}
> +
> +free_acpi_buffer:
> +=09kfree(output.pointer);
> +=09return ret;
> +}
> +
> +static int chromeos_acpi_device_probe(struct platform_device *pdev)
> +{
> +=09struct chromeos_acpi_attribute_group *aag;
> +=09struct device *dev =3D &pdev->dev;
> +=09int i, ret;
> +
> +=09aag =3D kzalloc(sizeof(*aag), GFP_KERNEL);
> +=09if (!aag)
> +=09=09return -ENOMEM;
> +
> +=09INIT_LIST_HEAD(&aag->attribs);
> +=09INIT_LIST_HEAD(&aag->list);
> +=09INIT_LIST_HEAD(&chromeos_acpi.groups);
> +
> +=09chromeos_acpi.root =3D aag;
> +
> +=09/*
> +=09 * Attempt to add methods by querying the device's MLST method
> +=09 * for the list of methods.
> +=09 */
> +=09if (!chromeos_acpi_process_mlst(pdev))
> +=09=09return 0;
> +
> +=09dev_dbg(dev, "falling back to default list of methods\n");
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(chromeos_acpi_default_methods); i++) {
> +=09=09ret =3D chromeos_acpi_add_method(pdev,
> +=09=09=09=09=09       chromeos_acpi_default_methods[i]);
> +=09=09if (ret) {
> +=09=09=09dev_err(dev, "failed to add default methods (%d)\n",
> +=09=09=09=09ret);
> +=09=09=09goto free_group_root;
> +=09=09}
> +=09}
> +
> +=09return 0;
> +
> +free_group_root:
> +=09kfree(chromeos_acpi.root);
> +=09return ret;
> +}
> +
> +static int chromeos_acpi_device_remove(struct platform_device *pdev)
> +{
> +=09/* Remove sysfs groups */
> +=09sysfs_remove_groups(&pdev->dev.kobj, chromeos_acpi.dev_groups);
> +=09kfree(chromeos_acpi.dev_groups);
> +
> +=09/* Remove allocated chromeos acpi groups and attributes */
> +=09chromeos_acpi_remove_groups();
> +
> +=09return 0;
> +}
> +
> +/* GGL is valid PNP ID of Google. PNP ID can be used with the ACPI devic=
es. */
> +static const struct acpi_device_id chromeos_device_ids[] =3D {
> +=09{ "GGL0001", 0 },
> +=09{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, chromeos_device_ids);
> +
> +static struct platform_driver chromeos_acpi_device_driver =3D {
> +=09.probe =3D chromeos_acpi_device_probe,
> +=09.remove =3D chromeos_acpi_device_remove,
> +=09.driver =3D {
> +=09=09.name   =3D "chromeos-acpi",
> +=09=09.acpi_match_table =3D ACPI_PTR(chromeos_device_ids)
> +=09}
> +};
> +
> +module_platform_driver(chromeos_acpi_device_driver);
> +
> +MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS specific ACPI extensions");
> --
> 2.30.2
>
>

Excuse me if I have missed previous discussions about it, but I am confused=
 by
the design. Why is a global variable needed here? The global struct's membe=
rs
are overwritten in the probe method in any case.

And checkpatch reports that no MAINTAINERS entry has been added for the new=
 file.
(And it appears to be right if I have not missed anything.)


Regards,
Barnab=C3=A1s P=C5=91cze
